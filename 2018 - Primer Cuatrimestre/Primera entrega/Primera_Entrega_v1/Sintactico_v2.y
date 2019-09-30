%{
#include <stdio.h>
#include <stdlib.h>
#include <conio.h>
#include "y.tab.h"
int yystopparser = 0;
FILE  *yyin;

%}

%token PROGRAM
%token VAR
%token ENDVAR
%token BEGINP
%token ENDP
%token REAL
%token INTEGER
%token STRING
%token FLOAT
%token DO
%token WHILE
%token IN
%token ENDWHILE
%token IF
%token THEN
%token ELSE
%token ENDIF
%token FIB
%token CTE_STR
%token DOS_PUNTOS
%token PUNTO
%token COMA
%token IGUAL
%token OP_COMP_IGUAL
%token OP_COMP_DIST
%token OP_COMP_MEN
%token OP_COMP_MAY
%token OP_COMP_MENIG
%token OP_COMP_MAYIG
%token OP_ASIG
%token CONCATENAR_STR
%token SIGNO_MAS
%token SIGNO_MENOS
%token SIGNO_POR
%token SIGNO_DIV
%token WRITE
%token READ
%token P_A
%token P_C
%token C_A
%token C_C
%token AND
%token OR
%token NOT
%token ID
%token CTE_INT
%token CTE_REAL


%%

programa:
	PROGRAM {printf("Inicia COMPILADOR\n");} est_declaracion algoritmo{printf("Fin COMPILADOR ok\n");} | 
	PROGRAM {printf("Inicia COMPILADOR\n");} algoritmo{printf("Fin COMPILADOR ok\n");}
	;

est_declaracion:
	  est_declaracion VAR {printf("\tDECLARACIONES\n");} declaraciones ENDVAR {printf("\tFin DECLARACIONES\n");}
    | est_declaracion VAR {printf("\tDECLARACIONES\n");} ENDVAR {printf("\tFin DECLARACIONES\n");}
    | VAR {printf("\tDECLARACIONES\n");} ENDVAR {printf("\tFin DECLARACIONES\n");} 
    | VAR {printf("\tDECLARACIONES\n");} declaraciones ENDVAR {printf("\tFin DECLARACIONES\n");}
     ;

declaraciones: tipo_dato DOS_PUNTOS lista_variables {printf("\t\tDECLARACION\n");} | 
		tipo_dato DOS_PUNTOS lista_variables {printf("\t\tDECLARACION\n");} declaraciones;

tipo_dato: C_A tipos C_C;

tipos: tipo | tipo COMA tipos;

tipo: INTEGER | FLOAT | STRING | REAL;

lista_variables: C_A listas C_C;

listas: ID | ID COMA listas;


algoritmo: BEGINP {printf("\tBLOQUES\n");} bloque ENDP {printf("\tFIN BLOQUES\n");};


bloque: sentencia | sentencia bloque;


sentencia: ciclo | seleccion | asignacion | i_o | ciclo_especial;


i_o: READ{printf("\t\tREAD\n"); } ID | WRITE{printf("\t\tWRITE\n");} ID | WRITE{printf("\t\tWRITE\n");} CTE_STR;


ciclo: WHILE{printf("\t\tWHILE\n");} P_A condicion P_C DO bloque ENDWHILE{printf("\t\tFin WHILE\n");} ;


asignacion: ID OP_ASIG expresion {printf("\t\tASIGNACION\n");} ;


ciclo_especial: WHILE{printf("\t\tWHILE ESPECIAL\n");} ID IN lista_exp_ce DO bloque ENDWHILE{printf("\t\tFin WHILE ESPECIAL\n");} ;


lista_exp_ce: C_A factor_ce C_C;


factor_ce: factor | factor COMA factor_ce


seleccion: principio_if ENDIF{printf("\t\tFin IF\n");} | 
	principio_if ELSE bloque ENDIF {printf("\t\tFin IF con ELSE\n");};


principio_if: IF{printf("\t\tIF\n");} P_A condicion P_C THEN bloque ;


condicion: comparacion 
         | comparacion op_log comparacion;


op_log: AND | OR; 


comparacion: comp | NOT comp;


comp: expresion op_comparacion expresion;


op_comparacion:	    OP_COMP_MEN
                 |  OP_COMP_MAY
                 |  OP_COMP_IGUAL
                 |  OP_COMP_MENIG
                 |  OP_COMP_MAYIG
                 |  OP_COMP_DIST;


expresion: termino | expresion op_sum_res termino;


fib: FIB P_A CTE_INT P_C;


op_sum_res: SIGNO_MAS | SIGNO_MENOS;


termino: factor | termino op_mult_div factor;


op_mult_div: SIGNO_POR | SIGNO_DIV; 


factor:  ID
	| CTE_INT
	| CTE_REAL
	| CTE_STR
	| P_A expresion P_C
	| fib;

%%


int main(int argc,char *argv[]){
	if ((yyin = fopen(argv[1], "rt")) == NULL){
		printf("\nNo se puede abrir el archivo: %s\n", argv[1]);
	}else{
		yyparse();
	}
  	fclose(yyin);
  	return 0;
}
int yyerror(void){
	printf("Syntax Error\n");
	system ("Pause");
	exit (1);
}

