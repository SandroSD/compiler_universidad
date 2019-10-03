%{
#include <stdio.h>
#include <stdlib.h>
#include <conio.h>
#include <string.h>
#include <math.h>
#include "y.tab.h"

typedef struct 
{
	char nombre[100];
	char tipo[100];
	char valor[50];
	char longitud[100];
} struct_tablaSimbolos;
//int guardar_en_tabla_simbolos(char*, char*);
//int crear_tabla_simbolos();
//int puntero_array = 0;
struct_tablaSimbolos tablaSimbolos[1000];

FILE  *yyin;
int yylval;

%}
%option noyywrap  
%option yylineno 

DIGITO					[0-9]
LETRA					[a-zA-Z]
COMA                    [","]
CONST_STR               "({LETRA}|{DIGITO}|.)+"
CONST_REAL              {DIGITO}+"."{DIGITO}+
CONST_INT               {DIGITO}+
COMENTARIOS             //({LETRA}|{DIGITO}|.)+//
ID						{LETRA}({LETRA}|{DIGITO}|_)*
REAL			["REAL"|"real"]
INTEGER			["INTEGER"|"integer"]
STRING			["STRING"|"string"]
WHILE			["WHILE"|"while"]
ENDWHILE		["ENDWHILE"|"endwhile"]
DO				["DO"|"do"]
IF				["IF"|"if"]
THEN			["THEN"|"then"]
ELSE			["ELSE"|"else"]
BETWEEN			["BETWEEN"|"between"]
OP_SUM			"+"
OP_RES			"-"
OP_MUL			"*"
OP_DIV			"/"
OP_IGU			"="
OP_ASIG			":="
AND				["AND"|"&&"|"and"]
OR				["OR"|"or"|"\|\|"]
OP_COMPARACION          ["<"|"="|">"|"<="|">="|"><"]
CAR_DECIMAL		"."
CAR_PYC			";"
CAR_COM			","
CAR_PUN			"."
CAR_DOSP		":"
CAR_CONBA		"\\"
CAR_PREGCIE		"?"	
CAR_PREGABR		"¿"
CAR_PA			"("
CAR_PC			")"
CAR_LLA			"{"
CAR_LLC			"}"
CAR_CA			"["
CAR_CC			"]"
CAR_COMILLA		"\""
%%

"float"			{ return FLOAT; }
{REAL}			{ return REAL; }
{INTEGER}		{ return INTEGER; }
{STRING}		{ return STRING; }
{WHILE}			{ return WHILE; }
"endwhile"		{ return ENDWHILE; }
{DO}			{ return DO; }
{IF}			{ return IF; }
{THEN}			{ return THEN; }
{ELSE}			{ return ELSE; }
{BETWEEN}		{ return BETWEEN; }
{OP_SUM}			{ return OP_SUM; }
{OP_RES}			{ return OP_RES; }
{OP_MUL}			{ return OP_MUL; }
{OP_DIV}			{ return OP_DIV; }
{OP_IGU}			{ return OP_IGU; }
{OP_ASIG}			{ return OP_ASIG; }
{AND}				{ return AND; }
{OR}				{ return OR; }
{OP_COMPARACION}    { return OP_COMPARACION; }
{CAR_DECIMAL}		{ return CAR_DECIMAL; }
{CAR_PYC}			{ return CAR_PYC; }
{CAR_COM}			{ return CAR_COM; }
{CAR_PUN}			{ return CAR_PUN; }
{CAR_DOSP}			{ return CAR_DOSP; }
{CAR_CONBA}			{ return CAR_CONBA; }
{CAR_PREGCIE}		{ return CAR_PREGCIE; }	
{CAR_PREGABR}		{ return CAR_PREGABR; }
{CAR_PA}			{ return CAR_PA; }
{CAR_PC}			{ return CAR_PC; }
{CAR_LLA}			{ return CAR_LLA; }
{CAR_LLC}			{ return CAR_LLC; }
{CAR_CA}			{ return CAR_CA; }
{CAR_CC}			{ return CAR_CC; }
{CAR_COMILLA}		{ return CAR_COMILLA; }

"\n"      		
"\t"		
%%


