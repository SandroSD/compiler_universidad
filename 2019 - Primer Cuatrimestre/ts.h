struct TablaSimbolos
{
    char *Nombre;
    char *Tipo;

    int IntVal;
    float FloatVal;
    char StrVal[30];

    char *Valor;
    int Longitud;

      //nombre tipo valor longitud
};


void AgregarTokenTS(char *Nombre, char *Prefijo);
int BuscarTokenTS(char *Nombre);
int EscribirArchivo(void);