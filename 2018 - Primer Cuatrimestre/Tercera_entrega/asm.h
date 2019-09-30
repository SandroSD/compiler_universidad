#ifndef ASM_H
#define ASM_H
#define PILA_LLENA -1
#define PILA_VACIA 0
#define TODO_OK 1
#define STR_VALUE 1024

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>


//generadorASM
void generarEncabezado();
void generarFin();
void generarDatos();
void generarCodigo();
void generarASM();
void imprimirInstrucciones();
void imprimirFuncString();
int informeError(char *);
void imprimirInstruccionPolaca(char*);

#endif