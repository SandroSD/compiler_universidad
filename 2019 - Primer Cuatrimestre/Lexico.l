%{
    #include <stdio.h>
    #include <stdlib.h>
    #include "y.tab.h"
    
    #define COTA_INT 2147483647
    #define COTA_FLOAT 3.402823E+38
%}

%option noyywrap
%option yylineno

DIGITO      [0-9]
LETRA       [a-zA-Z]
ID          {LETRA}({LETRA}|{DIGITO}|_)*
CONST_INT   "-"?
DIGITO                  [0-9]
LETRA                   [a-zA-Z]
ID                      {LETRA}({LETRA}|{DIGITO}|_)*
CONST_INT               "-"[1-9]+|{DIGITO}+
CONST_REAL              "-"?[1-9]*"."{DIGITO}*|{DIGITO}*"."{DIGITO}*

%%
"VAR"                   { return VAR; }
"ENDVAR"                { return ENDVAR; }
"repeat|REPEAT"         { return REPEAT; }
"until|UNTIL"           { return UNTIL; }
"if|IF"                 { return IF; }
"then|THEN"             { return THEN; }
"else|ELSE"             { return ELSE; }
"endif|ENDIF"           { return ENDIF; }
":="                    { return OP_ASIG; }
"+"                     { return OP_SUM; }
"-"                     { return OP_RES; }
"/"         			{ return OP_DIV; }
"*"         			{ return OP_MUL; }
":"         			{ return OP_DOSP; }
","         			{ return CAR_COMA; }
";"         			{ return CAR_PYC; }
"("         			{ return CAR_PA; }
")"         			{ return CAR_PC; }
"["  					{ return CAR_CA; }
"]"						{ return CAR_CC; }
"{"         			{ return CAR_LA; }
"}"         			{ return CAR_LC; }
">"         			{ return CMP_MAYOR; }
"<"         			{ return CMP_MENOR; }
">="        			{ return CMP_MAYORIGUAL; }
"<="        			{ return CMP_MENORIGUAL; }
"!="        			{ return CMP_DISTINTO; }
"=="        			{ return CMP_IGUAL; }
%%

