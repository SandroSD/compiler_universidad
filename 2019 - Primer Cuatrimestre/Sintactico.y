%{
	#include <stdio.h>
	#include <stdlib.h>
	#include <string.h>
	#include <math.h>
	#include "y.tab.h"

	FILE  *yyin;
	extern int yylex();
	void yyerror(char *msg);
%}

%union {
	int intValue;
	float floatValue;
	char *stringValue;
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

programa:  declaracion sentencias;

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

sent: iteracion|decision|entrada_salida|asignacion|cte_nombre {printf("Inicia el compilador\n");};

decision:
		IF CAR_PA condiciones CAR_PC CAR_LA sentencias CAR_LC   {printf("Regla de condicion: IF\n");}
	   |IF CAR_PA condiciones CAR_PC CAR_LA sentencias CAR_LC ELSE CAR_LA sentencias CAR_LC	{printf("Regla de condicion: IF Y ELSE\n");}
	;

iteracion:
		REPEAT CAR_PA condiciones CAR_PC CAR_LA sentencias CAR_LC   {printf("Regla de iteracion repeat\n");}
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
		expresion  CMP_MAYOR expresion				{printf("MAYOR\n");}
		|expresion CMP_MAYORIGUAL expresion			{printf("MAYOR IGUAL\n");}
		|expresion CMP_MENOR expresion				{printf("MENOR\n");}
		|expresion CMP_MENORIGUAL expresion			{printf("MENOR IGUAL\n");}
		|expresion CMP_IGUAL expresion				{printf("IGUAL\n");}
		|expresion CMP_DISTINTO expresion			{printf("DISTINTO\n");}
	;

asignacion: ID OP_ASIG expresion {printf("Regla de asignacion\n");};

sent_div: expresion DIV expresion {printf("Regla de DIV entre expresiones\n");};

sent_mod: expresion MOD expresion {printf("Regla de MOD entre expresiones\n");};

expresion:
		expresion OP_RES termino					{printf("Esto es una resta\n");}
		|expresion OP_SUM termino					{printf("Esto es una suma\n");}
		|termino									{printf("Termino\n");}
		|sent_div									{printf("Esto es una sentencia DIV\n");}
		|sent_mod									{printf("Esto es una sentencia MOD\n");}
	;
	
termino:
		termino OP_MUL factor		   		{printf("Esto es una multiplicacion\n");}
		|termino OP_DIV factor			    {printf("Esto es una division\n");}
		|factor								{printf("Factor\n");}
	; 
	
factor:     
		ID 									   {printf("Esto es un ID\n");}									
		|tipo 								   {printf("Esto es una cte\n");}
		|CAR_PA expresion CAR_PC         	   {printf("Esto es una expresion\n");}
	;

tipo: 
		CONST_INT    	{printf("Esto es un entero\n");}
		|CONST_REAL    	{printf("Esto es un real\n");}
	;

entrada_salida:
		READ ID 			{printf("Regla de lectura de entrada READ\n");}
		|PRINT ID 			{printf("Regla de escritura de salida PRINT de variable\n");}
		|PRINT CONST_STR    {printf("Regla de escritura de salida PRINT de constante\n");}
	;

cte_nombre: CONST ID OP_IGUAL CONST_STR {printf("Regla de asignacion de cte string con nombre\n");}
			| CONST ID OP_IGUAL CONST_REAL {printf("Regla de asignacion de cte real con nombre\n");}
			| CONST ID OP_IGUAL CONST_INT {printf("Regla de asignacion de cte entera con nombre\n");}
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
	//EscribirArchivo();
  }
  fclose(yyin);
  return 0;
}
//---------------------------------------- Validaciones ------------------------------------------//

void yyerror(char *msg){
    fprintf(stderr, "%s\n", msg);
    exit(1);
}