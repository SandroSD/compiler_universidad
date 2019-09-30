%{
#include <stdio.h>
#include <stdlib.h>
#include <conio.h>
#include "y.tab.h"
int yyerror();
int yylex();
int yystopparser=0;
FILE  *yyin;

%}

%start programa
%token PROGRAM
%token DECVAR
%token ENDDEC
%token DEFVAR
%token ENDDEF
%token CONST_INT
%token CONST_REAL
%token CONST_STR
%token REAL
%token INTEGER
%token STRING
%token BEGINP
%token ENDP
%token IF THEN ELSE ENDIF
%token FOR TO DO ENDFOR
%token WHILE ENDW
%token REPEAT UNTIL
%token OP_AND
%token OP_OR
%token OP_NOT
%token ID
%token OP_COMPARACION
%token OP_ASIG 
%token OP_DOSP
%token OP_SUM
%token OP_RES
%token OP_MUL
%token OP_DIV
%token CAR_COMA
%token CAR_PUNTO
%token CAR_PYC
%token CAR_PA 
%token CAR_PC
%token CAR_CA 
%token CAR_CC 
%token LONG
%token BETWEEN
%token IN
%token WRITE
%token READ


%%
programa:  	   
	PROGRAM {printf("\tInicia el COMPILADOR\n");} est_declaracion algoritmo    
	{printf("\tFin COMPILADOR ok\n");};

est_declaracion:
	DECVAR {printf("\t\tDECLARACIONES\n");} declaraciones ENDDEC {printf("\tFin de las Declaraciones\n");}
        ;
		
est_declaracion:
	DEFVAR {printf("\t\tDECLARACIONES DEF\n");} declaraciones ENDDEF {printf("\tFin de las Declaraciones DEF\n");}
        ;

declaraciones:         	        	
             declaracion
             | declaraciones declaracion
    	     ;

declaracion:  
           lista_var OP_DOSP REAL
			| lista_var OP_DOSP STRING
			| lista_var OP_DOSP INTEGER
           ;

lista_var:  
	 ID
	 | lista_var CAR_COMA ID   
 	 ;
	 
algoritmo: 
         BEGINP{printf("\tCOMIENZO de BLOQUES\n");} bloque ENDP
         ;

bloque:  
      sentencia
      |bloque sentencia
      ;

sentencia:
  	 ciclo
	 |seleccion  
	 |asignacion
     /*|asignacion_multiple*/
	 |entrada_salida
	 |between	 
	 ;

ciclo:
     REPEAT { printf("\t\tREPEAT\n");}bloque UNTIL condicion { printf("\t\tFIN DEL REPEAT\n");}
	 | WHILE { printf("\t\tWHILE\n");}CAR_PA condicion CAR_PC bloque ENDW{ printf("\t\tFIN DEL WHILE\n");}
     ;
/*
asignacion: 
          ID OP_ASIG expresion {printf("\t\tASIGNACION\n");} 		  
	  ;
	  
asignacion_multiple: 
        ID OP_ASIG 	asignacion_multiple	{printf("\t\tASIGNACION MULTIPLE\n");} 
		| ID OP_ASIG expresion {printf("\t\tASIGNACION MULTIPLE\n");}
	  ;
*/
asignacion:
			lista_id OP_ASIG expresion {printf("\t\tFIN LINEA ASIGNACION\n");}
	  ;

lista_id:
			lista_id OP_ASIG ID 
			| ID 
		;
	  
entrada_salida: 
	READ{printf("\t\tREAD\n"); } ID 
	|WRITE{printf("\t\tWRITE\n");} ID 
	|WRITE{printf("\t\tWRITE\n");} CONST_STR
;

seleccion: 
    	 IF CAR_PA condicion CAR_PC THEN bloque ENDIF{printf("\t\tENDIF\n");}
		| IF CAR_PA condicion CAR_PC THEN bloque ELSE bloque ENDIF {printf("\t\t IF CON ELSE\n");}	 
;

condicion:
         comparacion 
		 |OP_NOT comparacion{printf("\t\tNOT CONDICION\n");}
         |comparacion OP_AND comparacion{printf("\t\tCONDICION DOBLE AND\n");}
		 |comparacion OP_OR  comparacion{printf("\t\tCONDICION DOBLE OR\n");}
		 |OP_NOT CAR_PA comparacion OP_AND comparacion CAR_PC{printf("\t\tNOT CONDICION DOBLE AND\n");}
		 |OP_NOT CAR_PA comparacion OP_OR  comparacion CAR_PC{printf("\t\tNOT CONDICION DOBLE OR\n");}
		 |between
		 |OP_NOT between
	 ;

comparacion:
	   expresion OP_COMPARACION expresion
	   ;

expresion:
         termino
		|expresion OP_SUM termino
		|expresion OP_RES termino
 	 ;
	 
between: 
	BETWEEN CAR_PA ID CAR_COMA CAR_CA expresion CAR_PYC expresion CAR_CC CAR_PC {printf("\t\tBETWEEN\n");}
	 ;
	 
termino: 
       factor
       |termino OP_MUL factor
	   |termino OP_DIV factor
       ;

factor: 
      ID
      | CONST_INT
      | CONST_REAL
      | CONST_STR 
	  | CAR_PA expresion CAR_PC 	  
      ;

%%
int main(int argc,char *argv[])
{
	if ((yyin = fopen(argv[1], "rt")) == NULL)
	{
		printf("\nError al abrir archivo: %s\n", argv[1]);
	}
	else
	{
		yyparse();
	}
	fclose(yyin);
	return 0;
}
int yyerror()
{
	printf("ERROR - Syntax error\n");
	system ("Pause");
	exit (1);
}

