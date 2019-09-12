%{
	#include <stdio.h>
	#include <stdlib.h>
	#include <string.h>
	#include "y.tab.h"

	int yylineno
	FILE *yyin;
	int yylex();
	int yyerror(char *msg);
	int yyparse();
%}

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

//Empezamos a definir la gramática
%%
programa:
	{print_f("Inicia el compilador")}
	definiciones logica
	;

definiciones:
	VAR {print_f("Empieza la declaración de variables")}
	declaraciones
	ENDVAR {print_f("Finaliza la declaración de variables")}
	;

declaraciones:
	CAR_CA lista CAR_CC
	;

lista:
	TD CAR_COMA lista CAR_COMA ID
	|
	TD CAR_CC OP_DOSP CAR_CA ID
	;

TD:
	INT | FLOAT | STRING
	;
%%