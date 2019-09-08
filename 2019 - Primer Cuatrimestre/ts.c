#include "ts.h"

int puntero_ts = 0;
int posicion_en_ts = 0; // Incremento Longitud en la estructura tabla de simbolos

void insertarTokenEnTS(char *tipo, char *nombre)
{
	int i;

	for (i = 0; i < posicion_en_ts; i++)
	{
		if (strcmp(tablaSimbolos[i].nombre, nombre) == 0)
		{
			// En caso que el valor exista, sale de la funcion.
			return;
		}
	}
	// En caso que el valor no exista, se agrega a la estructura
	strcpy(tablaSimbolos[posicion_en_ts].tipo, tipo);
	strcpy(tablaSimbolos[posicion_en_ts].nombre, nombre);
	posicion_en_ts++;
}