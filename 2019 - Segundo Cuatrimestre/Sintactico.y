%{
	#include <stdio.h>
	#include <stdlib.h>
	#include <string.h>
	#include <math.h>
	#include "y.tab.h"
	#include "punto_h/ts.h"
	#include "punto_h/pila.h"
	#include "punto_h/constantes.h"

	int yylineno;
	FILE  *yyin;
	int yylex();
	void yyerror(char *msg);
	int yyparse();

	int crearArchivoIntermedia();
	int insertarEnLista(char *);
	void escribirEnLista(int , char *);

	int desapilar();
	void apilar(char * dato);
	int pilaVacia(int tope);
	int pilaLlena(int tope);
	
	//Para funcionamiento de la Polaca
	char * listaTokens[10000];
	char * aux;
	int puntero_tokens = 1;
	char * pila[100];
	int tope_pila_polaca = 0;
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
		if(crearArchivoIntermedia() == 1){
			printf("Archivo de intermedia generado correctamente \n");
		} else {
			printf("Hubo un error al generar el archivo de intermedia \n");
		}
		printf("Fin del parsing!\n");
	}
;

declaracion: 
		VAR linea_declaracion ENDVAR 		{printf("Regla de declaracion de variables\n");}
	;
	
linea_declaracion: 
		CAR_CA lista CAR_CC
	;
	
lista:	
		dec_tipo CAR_COMA lista CAR_COMA ID 
		|dec_tipo CAR_CC OP_DOSP CAR_CA ID 
	;
	
dec_tipo:
		INT | STRING | FLOAT 
	;

sentencias: sentencias sent | sent;

sent:	iteracion			|
		decision			|
		entrada_salida		|
		asignacion			|
		cte_nombre {printf("Inicia el compilador\n");}
	;

decision:
			IF CAR_PA condiciones CAR_PC CAR_LA sentencias CAR_LC
		|	IF CAR_PA condiciones CAR_PC CAR_LA sentencias CAR_LC ELSE CAR_LA sentencias CAR_LC
	;

iteracion:
		REPEAT CAR_PA condiciones CAR_PC CAR_LA sentencias CAR_LC   {printf("Regla de iteracion repeat\n");}
	;

condiciones:
			condicion
		|	condicion operador condicion  {printf("Esto es una condicion compuesta\n");}
	;
		
operador:
			AND			{printf("and\n");}
		|	OR			{printf("or\n");}
	;
	
condicion:
		expresion operador expresion
	;

operador:
			CMP_MAYOR		{
								//insertarEnLista("BLE");
							}
		|	CMP_MAYORIGUAL	{
								//insertarEnLista("BLT");
							}
		|	CMP_MENOR		{
								//insertarEnLista("BGE");
							}
		|	CMP_MENORIGUAL	{	
								//insertarEnLista("BGT");
							}
		|	CMP_IGUAL		{
								//insertarEnLista("BNE");
							}
		|	CMP_DISTINTO	{
								//insertarEnLista("BEQ");
							}
	;

asignacion: ID OP_ASIG expresion {printf("Regla de asignacion\n");};

//sent_div: expresion DIV expresion {printf("Regla de DIV entre expresiones\n");};
//sent_mod: expresion MOD expresion {printf("Regla de MOD entre expresiones\n");};

expresion:
			expresion OP_RES termino	{
											//insertarEnLista("-");
										}
		|	expresion OP_SUM termino	{
											//insertarEnLista("+");
										}
		|	termino
		//|sent_div									{printf("Esto es una sentencia DIV\n");}
		//|sent_mod									{printf("Esto es una sentencia MOD\n");}
	;
	
termino:
			termino OP_MUL factor	{
										//insertarEnLista("*");
									}
		|	termino OP_DIV factor	{
										//insertarEnLista("/");
									}
		|	factor
	; 
	
factor:
			ID						{
										insertarEnLista(yylval.stringValue);
									}
		|	tipo
		|	CAR_PA expresion CAR_PC
	;

tipo: 
			CONST_INT	{
							insertarEnLista(yylval.intValue);
						}
		|	CONST_REAL	{
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
							insertarEnLista(yylval.stringValue);
						}
			OP_IGUAL	
			tipo_const	{
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
	
	//escribo en archivo
	//fprintf(fintermedia,"%s\n",aux);
	
	// DEBUG por consola
	if(strcmp(aux,"###")!=0){
		printf("\tinsertar_en_polaca(%s)\n", aux);
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
		printf("Error: Se exedio el tamano de la pila.\n");
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
	//EscribirArchivo();
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