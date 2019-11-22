%{
	#include <stdio.h>
	#include <stdlib.h>
	#include <string.h>
	#include <math.h>
	#include "y.tab.h"
	#include "punto_h/ts.h"
	#include "punto_h/constantes.h"
	#include "punto_h/asm.h"

	int yylineno;
	FILE  *yyin;
	int yylex();
	void yyerror(char *msg);
	int yyparse();

	int crearArchivoIntermedia();
	int insertarEnLista(char *);
	void escribirEnLista(int , char *);
	void verificarTipoDato(int);
	void reiniciarTipoDato();
	void verificarVariableDup(char *);

	int desapilar();
	void apilar(char * dato);
	int pilaVacia(int tope);
	int pilaLlena(int tope);
	char * invertirComp(char* comp);
	
	//Para funcionamiento de la Polaca
	char * listaTokens[10000];
	char * aux;
	char * auxAsignacion;
	int puntero_tokens = 1;
	char * pila[100];
	int tope_pila_polaca = 0;
	char * comparador;

	//Tipos de datos para la tabla de simbolos
  	#define _INT 1
	#define _FLOAT 2
	#define _STRING 3

	//Variables globales para el control de la TS
	//int 
	int auxTipoDato[10000];
	char * auxID[10000];
	int posTipoDato = 0;
	int posID = 0;
	int tipoDatoActual = 0;
	int esDeclaracionVar = 0;
	int flagAND = 0;
	int flagOR = 0;
	int cantCond = 1;
%}

%union {
	char * intValue;
	char * floatValue;
	char * stringValue;
}

//Start Symbol
%start programa

//Tokens
%token VAR
%token ENDVAR
%token REPEAT
%token UNTIL
%token IF
%token THEN
%token ELSE
%token ENDIF
%token DIV
%token MOD
%token OP_ASIG
%token OP_SUM
%token OP_RES
%token OP_DIV
%token OP_MUL
%token OP_DOSP
%token CAR_COMA
%token CAR_PYC
%token CAR_PA
%token CAR_PC
%token CAR_CA
%token CAR_CC
%token CAR_LA
%token CAR_LC
%token CMP_MAYOR
%token CMP_MENOR
%token CMP_MAYORIGUAL
%token CMP_MENORIGUAL
%token CMP_DISTINTO
%token CMP_IGUAL
%token ID
%token INT
%token FLOAT
%token STRING
%token AND
%token OR
%token READ 
%token PRINT

%token OP_MOD
%token OP_IGUAL
%token CONST

%token CONST_INT
%token CONST_REAL
%token CONST_STR

//Empezamos a definir la gramática
%%

programa:  
	declaracion sentencias
	{
		crearArchivoTS();
		//generarASM();
		if(crearArchivoIntermedia() == 1){
			printf("Archivo de intermedia generado correctamente \n");
			generarASM();
		} else {
			printf("Hubo un error al generar el archivo de intermedia \n");
		}
		printf("Fin del parsing!\n");
	}
;

declaracion: 
		VAR {esDeclaracionVar = 1;}
		lista_declaracion ENDVAR {esDeclaracionVar = 0; printf("Regla de declaracion de variables\n");};

lista_declaracion: lista_declaracion linea_declaracion;

lista_declaracion: linea_declaracion;
	
linea_declaracion: 
		CAR_CA lista CAR_CC { 
			int i;
			for(i = 0; i<posID; i++)
				actualizarTipoDatoTS(auxID[i], auxTipoDato[i]);					
		}
	;	
lista:
			dec_tipo CAR_COMA lista CAR_COMA ID  {printf("Regla recursiva 1 - %s\n", yylval.stringValue);
			char * aux = (char *) malloc(sizeof(char) * (strlen(yylval.stringValue) + 1));
			strcpy(aux, yylval.stringValue); auxID[posID] = aux; posID++;}
			|	dec_tipo CAR_CC OP_DOSP CAR_CA ID    {printf("Regla recursiva 2 - %s\n", yylval.stringValue);
			char * aux = (char *) malloc(sizeof(char) * (strlen(yylval.stringValue) + 1));
			strcpy(aux, yylval.stringValue); auxID[posID] = aux; posID++;}
	;
	
dec_tipo:
		INT {printf("Esto es un INT\n"); auxTipoDato[posTipoDato] = _INT; posTipoDato++;}
		| STRING {printf("Esto es un STRING\n"); auxTipoDato[posTipoDato] = _STRING; posTipoDato++;}
		| FLOAT {printf("Esto es un FLOAT\n"); auxTipoDato[posTipoDato] = _FLOAT; posTipoDato++;}
	;

sentencias: sentencias sent | sent;

sent:	iteracion			|
		decision			|
		entrada_salida		|
		asignacion			|
		cte_nombre
	;

decision:
			IF CAR_PA condiciones CAR_PC then_ CAR_LA sentencias CAR_LC
			{
				int x;
				char sPosActual[5];
				x = desapilar();
				sprintf(sPosActual, "%d", puntero_tokens);
				escribirEnLista(x, sPosActual);
			}
		|	IF CAR_PA condiciones CAR_PC then_ CAR_LA sentencias CAR_LC else_ CAR_LA sentencias CAR_LC
			{
				int x;
				char sPosActual[5];
				x = desapilar();
				sprintf(sPosActual, "%d", puntero_tokens);
				escribirEnLista(x, sPosActual);
			}
	;

then_:
	THEN
		{
			char sPosActual[5];
			insertarEnLista("CMP");
			insertarEnLista(comparador);
			insertarEnLista("###");
			sprintf(sPosActual, "%d", puntero_tokens - 1);
			apilar(sPosActual);

			if(flagOR == 1){
				int auxOR;
				auxOR = desapilar();
				int x;
				x = desapilar();
				sprintf(sPosActual, "%d", puntero_tokens);
				escribirEnLista(x, sPosActual);

				sprintf(sPosActual, "%d", auxOR);
				apilar(sPosActual);
			} 
		}
	;
else_:
	ELSE
		{
			int x;
			char sPosActual[5];
			insertarEnLista("BI");
			insertarEnLista("###");
			if(flagAND == 1)
			{
				x = desapilar();
				sprintf(sPosActual, "%d", puntero_tokens);
				escribirEnLista(x, sPosActual);
				x = desapilar();
				sprintf(sPosActual, "%d", puntero_tokens);
				escribirEnLista(x, sPosActual);

				sprintf(sPosActual, "%d", puntero_tokens - 1);
				apilar(sPosActual);
			}else {
				x = desapilar();
				sprintf(sPosActual, "%d", puntero_tokens);
				escribirEnLista(x, sPosActual);
				sprintf(sPosActual, "%d", puntero_tokens - 1);
				apilar(sPosActual);
			}
		}
	;

iteracion:
		REPEAT{ 
			char sPosActual[5];
			sprintf(sPosActual, "%d", puntero_tokens);
			apilar(sPosActual); } 
			CAR_PA condiciones CAR_PC {
				char sPosActual[5];
				insertarEnLista("CMP");
				insertarEnLista(comparador);
				insertarEnLista("###");
				sprintf(sPosActual, "%d", puntero_tokens-1);
				apilar(sPosActual); } 
			CAR_LA sentencias CAR_LC   {
					int x;
					char value[4];
					char sPosActual[5];
					insertarEnLista("BI");

					x = desapilar();
					sprintf(sPosActual, "%d", puntero_tokens+1);
					escribirEnLista(x, sPosActual);

					
					x = desapilar();
					sprintf(value, "%d", x);
					insertarEnLista(value);
					sprintf(sPosActual, "%d", puntero_tokens);
					//escribirEnLista(puntero_tokens, value);
			}
	;

condiciones:
			condicion
		|	condicion operador condicion  {printf("Esto es una condicion compuesta\n");}
	;
		
operador:
			AND			{	char sPosActual[5];
							flagAND = 1;
							insertarEnLista("CMP");
							insertarEnLista(comparador);
							insertarEnLista("###");
							sprintf(sPosActual, "%d", puntero_tokens - 1);
							apilar(sPosActual); }
		|	OR			{ char sPosActual[5];
							flagOR = 1;
							insertarEnLista("CMP");
							insertarEnLista(invertirComp(comparador));
							insertarEnLista("###");
							sprintf(sPosActual, "%d", puntero_tokens - 1);
							apilar(sPosActual); }
	;
	
condicion:
		expresion operador expresion
	;

operador:
			CMP_MAYOR		{ comparador = "BLE"; /*BGT*/ } 
		|	CMP_MAYORIGUAL	{ comparador = "BLT"; /*BGE*/ }	
		|	CMP_MENOR		{ comparador = "BGE"; /*BLT*/ }
		|	CMP_MENORIGUAL	{ comparador = "BGT"; /*BLE*/ }
		|	CMP_IGUAL		{ comparador = "BNE"; /*BEQ*/ }
		|	CMP_DISTINTO	{ comparador = "BEQ"; /*BNE*/ }
	;

asignacion:
			ID { 
				 auxAsignacion = (char *) malloc(sizeof(char) * (strlen(yylval.stringValue) + 1));
			 	 strcpy(auxAsignacion, yylval.stringValue);
			   }
			OP_ASIG
			expresion { insertarEnLista(auxAsignacion);
			 			insertarEnLista(":="); }
	;

expresion:
			expresion OP_RES termino	{ insertarEnLista("-"); }
		|	expresion OP_SUM termino	{ insertarEnLista("+"); }
		|	expresion DIV termino		{ insertarEnLista("DIV"); printf("Esto es un DIV");}
		|	expresion { insertarEnLista("mod0"); insertarEnLista(":=");} 
			MOD termino	{ insertarEnLista("mod1"); insertarEnLista(":="); 
						   insertarEnLista("mod0"); insertarEnLista("mod1");
						   insertarEnLista("mod0"); insertarEnLista("mod1");
						   insertarEnLista("/"); insertarEnLista("*"); insertarEnLista("-"); printf("Esto es un MOD");}
		|	termino
	;
	
termino:
			termino OP_MUL factor	{ insertarEnLista("*"); }
		|	termino OP_DIV factor	{ insertarEnLista("/"); }
		|	factor
	; 
	
factor:
			ID						{
										int tipo = buscarTipoTS(yylval.stringValue);
										verificarTipoDato(tipo);
										insertarEnLista(yylval.stringValue);
									}
		|	tipo
		|	CAR_PA expresion CAR_PC
	;

tipo: 
			CONST_INT	{
							verificarTipoDato(1);
							insertarEnLista(yylval.intValue);
						}
		|	CONST_REAL	{
							verificarTipoDato(2);
							insertarEnLista(yylval.floatValue);
						}
	;

entrada_salida:
			READ ID 			{printf("Regla de lectura de entrada READ\n");}
		|	PRINT ID 			{printf("Regla de escritura de salida PRINT de variable\n");}
		|	PRINT CONST_STR    {printf("Regla de escritura de salida PRINT de constante\n");}
	;

cte_nombre: 
			CONST ID	{
							auxAsignacion = (char *) malloc(sizeof(char) * (strlen(yylval.stringValue) + 1));
			 	 			strcpy(auxAsignacion, yylval.stringValue);
						}
			OP_IGUAL	
			tipo_const	{
							insertarEnLista(auxAsignacion);
							insertarEnLista(":=");
						}
	;

tipo_const:
			CONST_STR	{
							insertarEnLista(yylval.stringValue);
						}
		|	CONST_INT	{
							insertarEnLista(yylval.intValue);
						}
		|	CONST_REAL	{
							insertarEnLista(yylval.floatValue);
						}

%%


int crearArchivoIntermedia() {
	FILE * archivo; 
	int i;
	archivo = fopen("intermedia.txt", "wt");

	if (!archivo) {
		return 0;
	}

	for (i = 1; i < puntero_tokens; i++) {
		fprintf(archivo,"%s\n", listaTokens[i]);
	}
	fclose(archivo); 

	return 1;
}

int insertarEnLista(char * val) {
	// Convierto en CHAR *
	aux = (char *) malloc(sizeof(char) * (strlen(val) + 1));
    strcpy(aux, val);
	
	// Agrego al array de tokens
	listaTokens[puntero_tokens] = aux;
	puntero_tokens++;
	
	// DEBUG por consola
	if(strcmp(aux,"###")!=0){
		printf("\tinsertar_en_polaca(%s), posicion -> %d\n", aux, puntero_tokens-1);
	}
	return (puntero_tokens-1); // devuelvo posicion
}

void escribirEnLista(int pos, char * val) {
	// Convierto en CHAR *
	aux = (char *) malloc(sizeof(char) * (strlen(val) + 1));
    strcpy(aux, val);
	
	// escribo en vector
	listaTokens[pos] = aux;
	
	printf("\tEscribio en %i el valor %s\n",pos,aux);
}

int buscarTipoTS(char* nombreVar) {

	int pos = existeTokenEnTS(nombreVar);
	if (pos == 0) {
		
		char *nomCte = (char*) malloc(31*sizeof(char));
		*nomCte = '\0';
		strcat(nomCte, "_");
		strcat(nomCte, nombreVar);
	
		char *original = nomCte;
		while(*nomCte != '\0') {
			if (*nomCte == ' ' || *nomCte == '"' || *nomCte == '!' 
				|| *nomCte == '.') {
				*nomCte = '_';
			}
			nomCte++;
		}
		nomCte = original;

		int pos = existeTokenEnTS(nomCte);
		if (pos == 0) {
			yyerror("La variable no fue declarada");
		}
	}
	
	return obtenerTipoDeDato(pos);

}

void verificarTipoDato(int tipo) {

	if(tipoDatoActual == 0) {
		tipoDatoActual = tipo;
		return;
	}
	
	if(tipoDatoActual != tipo) {
		yyerror("No se admiten operaciones aritmeticas con tipo de datos distintos");
	}
	
}

void reiniciarTipoDato() {
	tipoDatoActual = 0;
}

void verificarVariableDup(char * aux){

	if(existeTokenEnTS(aux) && esDeclaracionVar)
		yyerror("No se admiten variables duplicadas");
}

char* invertirComp(char* comp)
{
	char* aux = (char*) malloc(sizeof(char) * (strlen(comp) + 1));
	strcpy(aux,comp);

	if(strcmp(aux, "BGE") == 0){
		return "BLT";
	}
	if(strcmp(aux, "BLT") == 0){
		return "BGE";
	}
	if(strcmp(aux, "BGT") == 0){
		return "BLE";
	}
	if(strcmp(aux, "BEQ") == 0){
		return "BNE";
	}
	if(strcmp(aux, "BLE") == 0){
		return "BGT";
	}
	if(strcmp(aux, "BNE") == 0){
		return "BEQ";
	}
}

int desapilar(){
	if(pilaVacia(tope_pila_polaca) == 0){
		char * dato = pila[tope_pila_polaca - 1];
		tope_pila_polaca--;
		printf("\tDESAPILAR #CELDA -> %s\n",dato);
		return atoi(dato);
	}else{
		printf("Error: La pila esta vacia.\n");
		system ("Pause");
		exit (1);
	}
}

void apilar(char * dato) {
	if(pilaLlena(tope_pila_polaca) == 1){
		printf("Error: Se excedio el tamano de la pila.\n");
		system ("Pause");
		exit (1);
	}
	pila[tope_pila_polaca] = dato;
	printf("\tAPILAR #CELDA ACTUAL -> %s\n",dato);
	tope_pila_polaca++;
}

int pilaVacia(int tope) {
	if (tope-1 == -1){
		return 1;
	} 
	return 0;
}

int pilaLlena(int tope) {
	if (tope-1 == 100-1){
		return 1;
	} 
	return 0;
}

int main(int argc,char *argv[])
{
  if ((yyin = fopen(argv[1], "rt")) == NULL)
  {
	printf("\nNo se pudo abrir el archivo: %s\n", argv[1]);
  }
  else
  {
	yyparse();
  }
  fclose(yyin);
  return 0;
}
//---------------------------------------- Validaciones ------------------------------------------//

void yyerror(char *msg){
	fflush(stderr);
    fprintf(stderr, "%s\n", msg);
    exit(1);
}
