%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>
#include "y.tab.h"
#include "simbolos.h"

FILE  *yyin;
extern int yylex();
void yyerror(char *msg);
%}

%union {
	int intValue;
	float floatValue;
	char *stringValue;
}

%token ID
%token DECVAR
%token ENDDEC
%token ASIG 

%token MAYOR
%token MAYOR_IGUAL
%token MENOR
%token MENOR_IGUAL
%token IGUAL
%token DISTINTO   

%token SUMA 
%token RESTA
%token MULTIPLICACION
%token DIVISION
%token AVG

%token INT
%token FLOAT
%token STRING

%token T_ENTERO
%token T_FLOAT
%token T_STRING

%token IF
%token ELSE
%token WHILE

%token C_ABIERTO      
%token C_CERRADO
%token LL_ABIERTA
%token LL_CERRADA
%token P_ABIERTO 
%token P_CERRADO
%token DOS_PUNTOS
%token P_COMA
%token COMA

%token AND
%token OR

%token READ WRITE
%%

raiz: programa;

programa: sentencias;

sentencias: sentencias sent | sent;

sent: asignacion|promedio|declaracion|decision|iteracion|entrada_salida;
				
promedio: AVG P_ABIERTO C_ABIERTO f_promedio C_CERRADO P_CERRADO {printf("-----Regla de Promedio\n");};

f_promedio: expresion|f_promedio COMA expresion;

asignacion: lista expresion {printf("-----Regla de asignacion\n");};
lista: lista ID ASIG;
lista: ID ASIG;

declaracion: DECVAR linea_declaracion ENDDEC {printf("-----Regla de declaracion de variables\n");};
linea_declaracion: linea_declaracion lista_var dec_tipo;
linea_declaracion: lista_var dec_tipo;
lista_var: lista_var COMA ID;
lista_var: ID;

decision:
		IF P_ABIERTO condiciones P_CERRADO LL_ABIERTA sentencias LL_CERRADA	{printf("-----Regla de condicion: IF\n");}
		|IF P_ABIERTO condiciones P_CERRADO LL_ABIERTA sentencias LL_CERRADA ELSE LL_ABIERTA sentencias LL_CERRADA	{printf("-----Regla de condicion: IF Y ELSE\n");}
	;

iteracion:
		WHILE P_ABIERTO condiciones P_CERRADO LL_ABIERTA sentencias LL_CERRADA   {printf("-----Regla de iteracion while\n");}
	;

entrada_salida:
		READ ID {printf("-----Regla de lectura de entrada READ\n");}
		|WRITE ID {printf("-----Regla de escritura de salida WRITE de variable\n");}
		|WRITE tipo {printf("-----Regla de escritura de salida WRITE de constante\n");}
		;

condiciones:
			condiciones operador condicion		{printf("Condicion multiple\n");}
			|condicion							{printf("Condicion Individual\n");}
		;

operador:
		AND			{printf("and\n");}
		|OR			{printf("or\n");}
	;	

condicion:
		expresion MAYOR expresion				{printf("MAYOR\n");}
		|expresion MAYOR_IGUAL expresion		{printf("MAYOR IGUAL\n");}
		|expresion MENOR expresion				{printf("MENOR\n");}
		|expresion MENOR_IGUAL expresion		{printf("MENOR IGUAL\n");}
		|expresion IGUAL expresion				{printf("IGUAL\n");}
		|expresion DISTINTO expresion			{printf("DISTINTO\n");}
	;

expresion:
		expresion RESTA termino					{printf("Esto es una resta\n");}
		|expresion SUMA termino					{printf("Esto es una suma\n");}
		|termino								{printf("Termino\n");}
	;	

termino:
		termino MULTIPLICACION factor		   {printf("Esto es una multiplicacion\n");}
		|termino DIVISION factor			   {printf("Esto es una division\n");}
		|factor								   {printf("Factor\n");}
	;   
   
factor:     
		ID 									   {printf("Esto es un ID\n");}									
		|tipo 								   {printf("Esto es una cte\n");}
		|P_ABIERTO expresion P_CERRADO         {printf("Esto es una expresion\n");}
	;

tipo: 
		T_ENTERO    {printf("Esto es un entero\n");}
		|T_FLOAT    {printf("Esto es un float\n");}
		|T_STRING   {printf("Esto es un String\n");}
	;
dec_tipo:
		INT    {printf("Declarando variable entera\n");}
		|FLOAT    {printf("Declarando variable float\n");}
		|STRING   {printf("Declarando variable String\n");}
	;

%%
int main(int argc,char *argv[])
{
  if ((yyin = fopen(argv[1], "rt")) == NULL)
  {
	printf("\nNo se pudo abrir el archivo: %s\n", argv[1]);
  }
  else
  {
	yyparse();
	EscribirArchivo();
  }
  fclose(yyin);
  return 0;
}
//---------------------------------------- Validaciones ------------------------------------------//

void yyerror(char *msg){
    fprintf(stderr, "%s\n", msg);
    exit(1);
}
