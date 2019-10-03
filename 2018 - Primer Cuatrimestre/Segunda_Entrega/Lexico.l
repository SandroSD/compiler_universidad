%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "y.tab.h"
#define COTA_INT 2147483647
#define COTA_FLOAT	3.402823E+38
#define TODO_OK 1
#define ERROR 0

FILE  *yyin;
%}


%option noyywrap  
%option yylineno 

DIGITO			[0-9]
CONST_INT			"-"?({DIGITO})+
CONST_REAL		"-"?({DIGITO})+"."({DIGITO})*|({DIGITO})*"."({DIGITO})+
LETRA			[a-zA-Z]
COMENTARIO_SIMPLE		"-/"([^-/]|\n)*?"/-"
COMENTARIO_DOBLE		"-/"([^-/]|\n|{COMENTARIO_SIMPLE})*?"/-"
CONST_STR               {CAR_COMILLAS}({LETRA}|{DIGITO}|" "|_|@|%|{OP_COMPARACION}|{OP_SUM}|{OP_RES}|{OP_MUL}|{OP_DIV})*{CAR_COMILLAS}
ID						{LETRA}({LETRA}|{DIGITO}|_)*
OP_COMPARACION          ["<"|"="|">"|"<="|">="|"><"]
OP_SUM                  ["+"]
OP_RES					["-"]
OP_MUL                  ["*"]
OP_DIV					["/"]
OP_ASIG   				[":="]
OP_DOSP   				[":"]
OP_AND					["AND"|"and"|"&&"]
OP_OR					["OR"|"or"|"||"]
OP_NOT					["NOT"|"not"]
BETWEEN					["BETWEEN"|"between"]
CAR_COMA                   [","]
CAR_PYC                    [";"]
CAR_PUNTO                  ["."]
CAR_CA                     ["["]
CAR_CC                     ["]"]
CAR_PA                     ["("]
CAR_PC                     [")"]
CAR_COMILLAS			   ["\""]
%%
"program"		{ return PROGRAM;}
"PROGRAM"		{ return PROGRAM;}
"DECVAR"		{ return DECVAR;}
"decvar"		{ return DECVAR;}
"ENDDEC"		{ return ENDDEC;}
"enddec"		{ return ENDDEC;}
"DEFVAR"		{ return DEFVAR;}
"defvar"		{ return DEFVAR;}
"ENDDEF"		{ return ENDDEF;}
"enddef"		{ return ENDDEF;}
"beginp"		{ return BEGINP;}
"endp"			{ return ENDP; 	}
"ENDP"			{ return ENDP; 	}
{COMENTARIO_SIMPLE}	{  }
{COMENTARIO_DOBLE}	{  }
"real"			{ return REAL;}
"REAL"			{ return REAL;}
"float"			{ return REAL;}
"FLOAT"			{ return REAL;}
"integer"		{ return INTEGER;}
"INTEGER"		{ return INTEGER;}
"INT"			{ return INTEGER;}
"string"		{ return STRING;}
"STRING"		{ return STRING;}
"if"			{ return IF;}
"IF"			{ return IF;}
"then"   		{ return THEN;}
"THEN"   		{ return THEN;}
"else"   		{ return ELSE;}
"ELSE"   		{ return ELSE;}
"endif"	      { return ENDIF;}
"ENDIF"	      { return ENDIF;}
"for"			{ return FOR;}
"FOR"			{ return FOR;}
"to"		      { return TO;}
"TO"		      { return TO;}
"do"	         	{ return DO;}
"DO"	         	{ return DO;}
"endfor"		{ return ENDFOR;}
"ENDFOR"		{ return ENDFOR;}
"while"	      {return WHILE;}
"WHILE"	      {return WHILE;}
"in"	         	{return IN;}
"IN"	         	{return IN;}
"endw"  		{ return ENDW;}
"ENDW"  		{ return ENDW;}
"repeat"		{ return REPEAT;}
"REPEAT"		{ return REPEAT;}
"until"		{ return UNTIL;}
"UNTIL"		{ return UNTIL;}
"WRITE"		{ return WRITE; }
"write"		{ return WRITE; }
"READ"		{ return READ; }
"read"		{ return READ; }
":="		{ return OP_ASIG;}
"+"			{ return OP_SUM;}
"-"			{ return OP_RES;}
"*"			{ return OP_MUL;}
"/"			{ return OP_DIV;}
"["			{ return CAR_CA;}
"]"			{ return CAR_CC;}
"("			{ return CAR_PA;}
")"			{ return CAR_PC;}
";"			{ return CAR_PYC;}
">"                     { yylval.cmp_val = strdup(yytext); return OP_COMPARACION;}
">="                    { yylval.cmp_val = strdup(yytext); return OP_COMPARACION;}
"<"                     { yylval.cmp_val = strdup(yytext); return OP_COMPARACION;}
"<="                    { yylval.cmp_val = strdup(yytext); return OP_COMPARACION;}
"><"                    { yylval.cmp_val = strdup(yytext); return OP_COMPARACION;}
"="                     { yylval.cmp_val = strdup(yytext); return OP_COMPARACION;}
":"                     { return OP_DOSP;}
"&&"                   { return OP_AND;}
"AND"                   { return OP_AND;}
"and"                   { return OP_AND;}
"OR"                   { return OP_OR;}
"or"                   { return OP_OR;}
"||"                   { return OP_OR;}
"NOT"                   { return OP_NOT;}
"not"                   { return OP_NOT;}
"BETWEEN"		{ return BETWEEN;}
"between"		{ return BETWEEN;}
{ID}			{
					yylval.str_val = strdup(yytext);
					
					int cantCaracteres = strlen(yytext);
					if(cantCaracteres <= 20) {
						// push_TS("ID", yytext); 
						return ID; 
					} else {
						printf("ERROR - Nombre de variable muy largo. Maximo 20 caracteres\n");
						system ("Pause");
						exit(5);
					}
				}
{CONST_STR}		{ 
					yylval.str_val = strdup(yytext);
					int cantCaracteres = strlen(yytext);
					if(cantCaracteres <= 202) { //Cuenta las commillas tambien
						//push_TS("CONST_STR", yytext);
						return CONST_STR;
					} else {
						printf("ERROR - String muy largo. Maximo 200 caracteres\n");
						system ("Pause");
						exit(3);
					}
				}
{CAR_COMA}		{ return CAR_COMA;}
{CAR_PUNTO}		{ return CAR_PUNTO;}
{CONST_INT}	{ 
				yylval.int_val = yytext;
				
				int num = atoi(yytext); 
				if(num >= COTA_INT*(-1) && num <= COTA_INT){
					//push_TS("CONST_INT", yytext);
					return CONST_INT; 
				}else{
					printf("ERROR - Int fuera de rango.\n");
					system ("Pause");
					exit(1);
				}
			}
{CONST_REAL}	{ 
				
					yylval.real_val = yytext;

					double n;
					n = atof(yytext);
					
					if(n >= COTA_FLOAT*(-1) && n <= COTA_FLOAT){
						//push_TS("CONST_REAL", yytext);
						return CONST_REAL; 
					}else{
						printf("ERROR - Real fuera de rango.\n");
						system ("Pause");
						exit(2);
					}
			}

"\n"      		
"\t"		
" "
"\r\n"

%%
