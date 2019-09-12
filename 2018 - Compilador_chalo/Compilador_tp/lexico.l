%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "y.tab.h"
#include "simbolos.h"
#include "constantes.h"

%}

%option noyywrap
%option yylineno

DIGITO			[0-9]
LETRA			[a-zA-Z]
ID				{LETRA}({LETRA}|{DIGITO}|_)*
A_COMENTARIO	"-/"
C_COMENTARIO	"/-"
CONTENIDO		[a-zA-Z0-9 "",=,>,<,!,:,+,-,*,/,@]*

ESPACIO         [" "]
CARACTER        [a-z,A-Z,0-9,=,>,<,!,:,+,-,*,/,@]
TEXTO           "\""({CARACTER}+|{ESPACIO})*"\""
INT             {DIGITO}+
FLOAT           ({DIGITO}*".")?{DIGITO}+
COMENTARIO 		({A_COMENTARIO}{CONTENIDO}{C_COMENTARIO})	


%%
INT             {return INT;}
FLOAT           {return FLOAT;}
STRING          {return STRING;}

DECVAR			{return DECVAR;}
ENDDEC			{return ENDDEC;}

WRITE           {return WRITE;}
READ            {return READ;}

while			{return WHILE;}
if				{return IF;}
else			{return ELSE;}
AVG				{return AVG;}
{ID}			{ 
                    if (strlen(yytext) > COTA_ID) {
                        printf( "El string ingresado supera la cantidad maxima permitida. Cantidad: %d\n", COTA_ID);
                        exit(1);
                    }
                    yylval.stringValue = strdup(yytext);
                    printf( "Identificador en lexico: %s\n",yylval.stringValue);
                    AgregarTokenTS(yylval.stringValue, "_");
                    return ID;
                }
{COMENTARIO} 	


{TEXTO}		    {   
                    if (strlen(yytext) > COTA_STR) {
                        printf( "El string ingresado supera la cantidad maxima permitida. Cantidad: %d\n", COTA_STR);
                        exit(1);
                    }
                    yylval.stringValue = strdup(yytext);
                    printf( "String en lexico: %s\n", yylval.stringValue);
                    AgregarTokenTS(yylval.stringValue, "#");
                    return T_STRING;                
                }

{INT}	        {
                    if (atoi(yytext) > COTA_INT) {
                        printf( "El entero ingresado supera la cantidad maxima permitida. Cantidad: %d\n", COTA_INT);
                        exit(1);
                    }
                    AgregarTokenTS(strdup(yytext), "&");
                    yylval.intValue = atoi(yytext); 
                    printf( "Entero en lexico: %d\n", yylval.intValue); 
                    return T_ENTERO;
                }

{FLOAT}         {
                    if (atof(yytext) > COTA_FLOAT) {
                        printf( "El flotante ingresado supera la cantidad maxima permitida. Cantidad: %f\n", COTA_FLOAT);
                        exit(1);
                    }  
                    yylval.floatValue = atof(yytext);
                    AgregarTokenTS(strdup(yytext), "$"); 
                    printf( "Float en lexico: %f\n", yylval.floatValue); 
                    return T_FLOAT;
                }


"+"				{return SUMA;}
"-"				{return RESTA;}
"*"				{return MULTIPLICACION;}	
"/"				{return DIVISION;}	
"("				{return P_ABIERTO;}	
")"				{return P_CERRADO;}
"["				{return C_ABIERTO;}
"]"				{return C_CERRADO;}
"{"				{return LL_ABIERTA;}	
"}"				{return LL_CERRADA;}
":="			{return ASIG;}
":"				{return DOS_PUNTOS;}
";"				{return P_COMA;}
","				{return COMA;}
">"				{return MAYOR;}
">="			{return MAYOR_IGUAL;}
"<"				{return MENOR;}
"<="			{return MENOR_IGUAL;}
"=="			{return IGUAL;}
"!="			{return DISTINTO;}
"&&"			{return AND;}
"||"			{return OR;}

"\n"      		
"\t"
%%
