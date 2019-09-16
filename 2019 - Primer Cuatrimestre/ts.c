#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "ts.h"

FILE *tsFile;

struct TablaSimbolos Simbolos[100];
int cantSimbolos = 0;
char *aux;

void AgregarTokenTS(char *Nombre, char* Prefijo){
    aux = NULL;
    aux = malloc(strlen(Nombre)+strlen(Prefijo)+1);
    strcpy(aux, Prefijo);
    strcat(aux, Nombre);
    if (BuscarTokenTS(aux) == -1){
        Simbolos[cantSimbolos].Nombre = malloc(strlen(aux)+1);
        strcpy(Simbolos[cantSimbolos].Nombre, aux);
        cantSimbolos++;    
    }
}

int EscribirArchivo(void){
    tsFile = fopen("ts.txt", "w");
    if (!tsFile) {
        return -1; // error
    }

    int i = 0;

    fprintf(tsFile,"******Tabla de Simbolos******\n");
    fprintf(tsFile,"***El tipo del simbolo lo identificamos con el caracter que precede al nombre. Siendo estos:\n\t_ --> variable\n\t$ --> cte float\n\t& --> cte int\n\t# --> cte string\n\n");
    for (i = 0; i < cantSimbolos; ++i) {
        fprintf(tsFile, "%s\n", Simbolos[i].Nombre);
    }

    fclose(tsFile);

    return 0;
}

int BuscarTokenTS(char *Nombre){

   int i;

   for (i=0; i<cantSimbolos; i++)
   {
	 if (strcmp(Nombre,Simbolos[i].Nombre) == 0)
	 {
	    return i; 
	 }
   }
   return -1;
}