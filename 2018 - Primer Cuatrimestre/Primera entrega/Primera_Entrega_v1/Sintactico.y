%{
#include <stdio.h>
#include <stdlib.h>
#include <conio.h>
#include "y.tab.h"
int yystopparser = 0;
FILE  *yyin;

char *yytext;
void yyerror(char *msg);

%}

%token	DIGITO
%token	NUMERO
%token	NUMERO_REAL
%token	MINUS
%token	MAYUS
%token	LETRA
%token	CADENA
%token	CARACTER
%token	CARACTER_ESP
%token	ID
%token	COM_A
%token	COM_B
%token	ESPACIO
%token	REAL
%token	INTEGER
%token	STRING
%token	FLOAT
%token	WHILE
%token	ENDWHILE
%token	DO
%token	IF
%token	THEN
%token	ELSE
%token	OP_SUM
%token	BETWEEN
%token	OP_RES
%token	OP_MUL
%token	OP_DIV
%token	OP_IGU
%token	OP_ASIG
%token	AND
%token	OR
%token	COMP_IGU
%token	COMP_DIS
%token	COMP_MAY
%token	COMP_MEN
%token	COMP_MAYI
%token	COMP_MINI
%token	CAR_DECIMAL
%token	CAR_PYC
%token	CAR_COM
%token	CAR_PUN
%token	CAR_DOSP
%token	CAR_PREGCIE
%token	CAR_CONBA
%token	CAR_PREGABR
%token	CAR_PA
%token	CAR_PC
%token	CAR_LLA
%token	CAR_LLC
%token	CAR_CA
%token	CAR_CC
%token	CAR_COMILLA
	
%%
programa: {printf("Inicia COMPILADOR\n");asignacion_mult}
asignacion_mult: lista OP_ASIG sentencia
between: BETWEEN CAR_PA ID CAR_COM CAR_CA sentencia CAR_PYC sentencia CAR_CC CAR_PC
lista: lista OP_IGU ID | ID
sentencia: sentencia OP_SUM expresion
sentencia: sentencia OP_RES expresion
sentencia: expresion
expresion: expresion OP_MUL factor
expresion: expresion OP_DIV factor
expresion: factor
factor: ID | NUMERO | NUMERO_REAL | CAR_PA expresion CAR_PC
%%

int main(int argc,char *argv[])
{
  if ((yyin = fopen(argv[1], "rt")) == NULL)
  {
	printf("\nNo se puede abrir el archivo: %s\n", argv[1]);
  }
  else
  {
	yyparse();
  }
  fclose(yyin);
  return 0;
}

void yyerror(char *msg){
    fprintf(stderr, "%s\n", msg);
    exit(1);
}