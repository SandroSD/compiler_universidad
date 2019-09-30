%{
#include <stdio.h>
#include <stdlib.h>
#include <conio.h>
#include <string.h>
#include <math.h>
#include "y.tab.h"

struct struct_tablaSimbolos{
	char nombre[100];
	char tipo[100];
	char valor[50];
	char longitud[100];
};
int guardar_en_tabla_simbolos(char*, char*);
int crear_tabla_simbolos();
int puntero_array = 0;
struct struct_tablaSimbolos tablaSimbolos[1000];

FILE  *yyin;
int yylval;

%}

%option noyywrap
%option yylineno

DIGITO			[0-9]
NUMERO			{DIGITO}+
NUMERO_REAL		({NUMERO}*){CAR_DECIMAL}({NUMERO}*)
MINUS			[a-z]
MAYUS			[A-Z]
LETRA			({MINUS}|{MAYUS})+
CADENA			{CAR_COMILLA}{CARACTER}{CAR_COMILLA}
CARACTER		({DIGITO}|{LETRA}|{CARACTER_ESP})+
CARACTER_ESP	[@#()?¿*´{} [],.:;-+$]
ID				"$"({MINUS}|{MAYUS})+
COM_A			"-/"({LETRA}|{DIGITO}|_|{ESPACIO}|":"|"="|".")*"/-"
COM_B			"-/"({LETRA}|{DIGITO}|_|{ESPACIO}|":"|"="|"."|{COM_A})*"/-"
ESPACIO			[" "]
REAL			"REAL"|"real"
INTEGER			"INTEGER"|"integer"
STRING			"STRING"|"string"
FLOAT			"FLOAT"|"float"
WHILE			"WHILE"|"while"
ENDWHILE		"ENDWHILE"|"endwhile"
DO				"DO"|"do"
IF				"IF"|"if"
THEN			"THEN"|"then"
ELSE			"ELSE"|"else"
BETWEEN			"BETWEEN"|"between"
OP_SUM			"+"
OP_RES			"-"
OP_MUL			"*"
OP_DIV			"/"
OP_IGU			"="
OP_ASIG			":="
AND				"AND"|"&&"|"and"
OR				"OR"|"or"|"\|\|"
COMP_IGU		"=="
COMP_DIS		"!="
COMP_MAY		">"
COMP_MEN		"<"
COMP_MAYI		">="
COMP_MINI		"<="
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

{REAL}			{ return REAL; }
{INTEGER}		{ return INTEGER; }
{CADENA}		{ return CADENA; }
{STRING}		{ return STRING; }
{FLOAT}			{ return FLOAT; }
{DO}	        { return DO; }
{WHILE}			{ return WHILE; }
{ENDWHILE}		{ return ENDWHILE; }
{IF}			{ return IF; }
{ELSE}			{ return ELSE; }
{BETWEEN}			{ return BETWEEN; }
{OP_SUM}			{ return OP_SUM; }
{OP_RES}			{ return OP_RES; }
{OP_MUL}			{ return OP_MUL; }
{OP_DIV}			{ return OP_DIV; }
{OP_IGU}			{ return OP_IGU; }
{OP_ASIG}			{ return OP_ASIG; }
{COMP_IGU}		{return COMP_IGU;}
{COMP_DIS}		{return COMP_DIS;}
{COMP_MAY}		{return COMP_MAY;}
{COMP_MEN}		{return COMP_MEN;}
{COMP_MAYI}		{return COMP_MAYI;}
{COMP_MINI}		{return COMP_MINI;}
{CAR_DECIMAL}		{return CAR_DECIMAL;}
{CAR_PYC}			{return CAR_PYC;}
{CAR_COM}		{return CAR_COM;}
{CAR_PUN}			{return CAR_PUN;}
{CAR_DOSP}		{return CAR_DOSP;}
{CAR_CONBA}		{return CAR_CONBA;}
{CAR_PREGCIE}		{return CAR_PREGCIE;}	
{CAR_PREGABR}		{return CAR_PREGABR;}
{CAR_PA}			{return CAR_PA;}
{CAR_PC}			{return CAR_PC;}
{CAR_LLA}			{return CAR_LLA;}
{CAR_LLC}			{return CAR_LLC;}
{CAR_CA}			{return CAR_CA;}
{CAR_CC}			{return CAR_CC;}
{CAR_COMILLA}		{return CAR_COMILLA;}

{COM_A}	{  }
{COM_B}	{  }
{NUMERO}	{ 
				int num = atoi(yytext); 
				if(num >= 0 && num <= 65535){
					guardar_en_tabla_simbolos("CTE_INT", yytext);
					return CTE_INT; 
				}else{
					printf("Error. Integer fuera de rango.\n");
					system ("Pause");
					exit(1);
				}
			}
{NUMERO_REAL}	{ 
				double num = atof(yytext);
				double cotaMayor = (3.4)*(exp(38));
				if(num >= 0 && num <= cotaMayor){
					guardar_en_tabla_simbolos("CTE_REAL", yytext);
					return CTE_REAL; 
				}else{
					printf("Error. Real fuera de rango.\n");
					system ("Pause");
					exit(2);
				}
			}
%%
int guardar_en_tabla_simbolos(char* tipo, char* nombre){
	//printf("tipo: %s   -   nombre: %s\n", tipo, nombre);
	int i;
	int retornar;
	for(i = 0; i < puntero_array; i++){
		if(strcmp(tablaSimbolos[i].nombre, nombre) == 0){
			//printf("lex: %s   -   tipo: %s   -   pos: %d\n", nombre, tipo, i);
			return i;
		}
	}
	strcpy(tablaSimbolos[puntero_array].tipo, tipo);
	strcpy(tablaSimbolos[puntero_array].nombre, nombre);
	retornar = puntero_array;
	puntero_array++;
	//printf("lex: %s   -   tipo: %s   -   pos: %d\n", nombre, tipo, i);
	return retornar;
}

int crear_tabla_simbolos(){
	FILE *pf; 
	int i;
	pf = fopen("ts.txt","w"); 

	if (!pf)
		return 0;

	fprintf(pf, "Nombre \t \t Tipo \t \t Valor \t \t Longitud\n");
	for (i = 0; i < puntero_array; i++)
		if (strcmp(tablaSimbolos[i].tipo, "ID") == 0 )  
			fprintf(pf,"%s\n", tablaSimbolos[i].nombre);
		else
			fprintf(pf,"_%s\n", tablaSimbolos[i].nombre);
	fclose(pf); 

	return 1;
}

