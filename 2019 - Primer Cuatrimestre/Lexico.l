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