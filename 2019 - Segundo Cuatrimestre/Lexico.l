%{
	#include <stdio.h>
	#include <stdlib.h>
	#include <string.h>
    #include "y.tab.h"
	#include "punto_h/constantes.h"
    #include "punto_h/ts.h"
%}

%option noyywrap
%option yylineno

DIGITO_CON_CERO			[0-9]
DIGITO_SIN_CERO			[1-9]
LETRA					[a-zA-Z]
ID						{LETRA}({LETRA}|{DIGITO_CON_CERO}|_)*
CONST_INT				"-"{DIGITO_SIN_CERO}+|{DIGITO_CON_CERO}+
CONST_REAL				"-"{DIGITO_CON_CERO}+"."{DIGITO_CON_CERO}*|{DIGITO_CON_CERO}*"."{DIGITO_CON_CERO}+|{DIGITO_CON_CERO}+"."{DIGITO_CON_CERO}*
CONST_STR          		"\""({CARACTER}|{ESPACIO})*"\""
CARACTER        		[a-z,A-Z,0-9,=,>,<,!,:,+,-,*,/,@]
ESPACIO         		[" "]
A_COMENTARIO			"--/"
C_COMENTARIO			"/--"
CONTENIDO				[a-zA-Z0-9 "",=,>,<,!,:,+,-,*,/,@]*
COMENTARIO 				{A_COMENTARIO}{CONTENIDO}{C_COMENTARIO}
COMENTARIO_ANIDADO		{A_COMENTARIO}({COMENTARIO}|{CONTENIDO})*?{C_COMENTARIO}

%%
VAR|var					{ return VAR; }
ENDVAR|endvar			{ return ENDVAR; }
repeat|REPEAT			{ return REPEAT; }
until|UNTIL				{ return UNTIL; }
if|IF					{ return IF; }
then|THEN				{ return THEN; }
else|ELSE				{ return ELSE; }
endif|ENDIF				{ return ENDIF; }
int|INT					{ return INT; }
float|FLOAT				{ return FLOAT; }
string|STRING			{ return STRING; }
const|CONST				{ return CONST; }
div|DIV					{ return DIV;}
mod|MOD					{ return MOD;}

"+"						{ return OP_SUM; }
"--"					{ return OP_RES; }
"/"						{ return OP_DIV; }
"*"						{ return OP_MUL; }
"%"						{ return OP_MOD; }
":="					{ return OP_ASIG; }
"="						{ return OP_IGUAL; }
":"						{ return OP_DOSP; }
","						{ return CAR_COMA; }
";"						{ return CAR_PYC; }
"("						{ return CAR_PA; }
")"						{ return CAR_PC; }
"["						{ return CAR_CA; }
"]"						{ return CAR_CC; }
"{"						{ return CAR_LA; }
"}"						{ return CAR_LC; }
">"						{ return CMP_MAYOR; }
"<"						{ return CMP_MENOR; }
">="					{ return CMP_MAYORIGUAL; }
"<="					{ return CMP_MENORIGUAL; }
"!="					{ return CMP_DISTINTO; }
"=="					{ return CMP_IGUAL; }
"&&"					{ return AND; }
"||"					{ return OR; }

PRINT           		{return PRINT;}
READ            		{return READ;}

{CONST_INT}				{
							if (atoi(yytext) > COTA_INT) {
								printf( "El entero ingresado supera la cantidad maxima permitida. Cantidad: %d\n", COTA_INT);
								exit(1);
							}
							insertarTokenEnTS("CONST_INT", strdup(yytext), 0, yytext);
							yylval.intValue = yytext; 
							printf( "Entero en lexico: %d\n", yylval.intValue); 
							return CONST_INT;
						}
{CONST_REAL}      		{
							if (atof(yytext) > COTA_FLOAT) {
								printf( "El flotante ingresado supera la cantidad maxima permitida. Cantidad: %f\n", COTA_FLOAT);
								exit(1);
							}  
							yylval.floatValue = yytext;
							insertarTokenEnTS("CONST_REAL", strdup(yytext), 0, yytext);
							printf( "Float en lexico: %f\n", yylval.floatValue); 
							return CONST_REAL;
						}
{CONST_STR}    			{	
					        if (strlen(yytext) > COTA_STR) { 
							    printf( "El string ingresado supera la cantidad maxima permitida. Cantidad: %d\n", COTA_STR);
								exit(1);
					        } else {
							    yylval.stringValue = strdup(yytext);
								printf( "String en lexico: %s\n", yylval.stringValue);
								insertarTokenEnTS("CONST_STR", yylval.stringValue, strlen(yytext), yylval.stringValue);
								return CONST_STR; 
					        }
						}
{ID}        			{
							if (strlen(yytext) > COTA_ID) {
								printf( "El string ingresado supera la cantidad maxima permitida. Cantidad: %d\n", COTA_ID);
								exit(1);
							}
							yylval.stringValue = strdup(yytext);
							printf( "Identificador en lexico: %s\n",yylval.stringValue);
							verificarVariableDup(yylval.stringValue);
							insertarTokenEnTS("ID", yylval.stringValue, strlen(yytext), "");
							return ID;
                        }
{COMENTARIO} 			{ }
{COMENTARIO_ANIDADO} 	{ }
"\n"					{ }
"\r\n"					{ }
"\t"					{ }
" "						{ }
%%