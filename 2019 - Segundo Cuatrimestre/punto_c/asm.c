#include "asm.h"
#define TRUE 1
#define FALSE 0
#define PILA_LLENA -1
#define PILA_VACIA 0
#define TAM_PILA 100

FILE *pfASM; //Final.asm
typedef struct s_elemento
{
    char* nombre;
	char* tipo;
    char* valor;
}t_elemento;

char * pilaASM[TAM_PILA];       // pila 5
int topePila=0;             // pila 0

char* vec_etiquetas[100];
int cant_elementos_etiq=0;

char* pila_auxiliares[TAM_PILA];
int topePilaAuxiliares=0;

int cont_aux=1; // incrementa cada vez que guardo un @aux en pila 
int celda_actual=0; //utilizado para los saltos
int flag_leer_salto=0;
int flag_write=0;

void ponerEnPila(char * str);
char* sacarDePila();
int pVacia(int tope);
int pLlena(int tope);
void debugP(int tope);

void insertarEtiqueta(char* str);

int concatenarString = 1;
char* vecTablaSimbolos[500];
char* obtenerTipoTS(char* nombre_elemento);
void cargarVectorEtiquetas();


void generarASM() {

    //Abrir archivo Final.asm
    if(!(pfASM = fopen("Final.asm", "wt+"))) {
        if(!(pfASM = fopen("Final.asm", "wt+"))) {
            informeError("Error al crear el archivo Final.asm, verifique los permisos de escritura.");
        }
    }
	
   
    //Generar archivo ASM
    fprintf(pfASM, ";\n;ARCHIVO FINAL.ASM\n;\n");

    generarEncabezado();
    generarDatos();
	cargarVectorEtiquetas();
    generarCodigo();
    generarFin();
	
    //Cerrar archivo
    fclose(pfASM);
}

void generarEncabezado() {
    //Encabezado del archivo
    fprintf(pfASM, "\nINCLUDE macros2.asm\t\t ;incluye macros\n");
    fprintf(pfASM, "INCLUDE number.asm\t\t ;incluye el asm para impresion de numeros\n");
    //fprintf(pfASM, "INCLUDE string.asm\t\t ;incluye el asm para manejo de strings\n");    		 
    fprintf(pfASM, "\n.MODEL LARGE ; tipo del modelo de memoria usado.\n");
    fprintf(pfASM, ".386\n");
    fprintf(pfASM, ".STACK 200h ; bytes en el stack\n"); 
}


void generarDatos() {
	FILE *pfTS;
	int nro_linea=1;
    char linea[30];
    int i = 0;
    char aux[STR_VALUE];
	char* token; // para el split de linea
	char nombre_elemento[50];
	char tipo_elemento[50];
	char valor_elemento[200];
	char longitud_elemento[50];
    //Encabezado del sector de datos
    fprintf(pfASM, "\t\n.DATA ; comienzo de la zona de datos.\n");    
    fprintf(pfASM, "\tTRUE equ 1\n");
    fprintf(pfASM, "\tFALSE equ 0\n");
    fprintf(pfASM, "\tMAXTEXTSIZE equ %d\n",200); //cota STR
	
    fprintf(pfASM, "\tR1 dd ?\n",200);	
	int cant_aux = 1;
	while(cant_aux<=15){	
		fprintf(pfASM, "\t@aux%d dd ?\n",cant_aux);
		cant_aux++;
	}    
	
	if(!(pfTS = fopen("ts2.txt", "r+"))) {
         informeError("Error al abrir el archivo ts2.txt, verifique los permisos de escritura.");
    }
	
	int pos=1; //1=nombre/2=tipo/3=longitud/4=valor
	size_t lin;
	
	
	 while(fgets(linea, 30, pfTS) != NULL) {
    	
		lin = strlen(linea)-1;
    	if(linea[lin] == '\n'){linea[lin] = '\0';}
        
		
		if(strcmp(linea,"*****")==0){
			pos=1;
			
			if(strcmp(tipo_elemento,"CONST_INT")==0){
				fprintf(pfASM, "\t%s dd %s\n",nombre_elemento,valor_elemento); 
			}else{
				if(strcmp(tipo_elemento,"CONST_STR")==0){
					if(strcmp(valor_elemento,"-") == 0){
						fprintf(pfASM, "\t_%s db MAXTEXTSIZE dup(?), '$'\n",nombre_elemento);
					}else{	
						fprintf(pfASM, "\t_%s db %s, '$', %s dup(?)\n", nombre_elemento, valor_elemento, longitud_elemento);
					}
				}else{
					if(strcmp(tipo_elemento,"CONST_REAL")==0){
						fprintf(pfASM, "\t%s dd %s\n",nombre_elemento,valor_elemento);
					}else{
						if(strcmp(tipo_elemento,"STRING")==0){
							fprintf(pfASM, "\t_%s db MAXTEXTSIZE dup(?), '$'\n",nombre_elemento);
						}else{
							fprintf(pfASM, "\t_%s dd ?\n",nombre_elemento); //IDs
						}
					}
				
				}
			}
			
			
		}else{
			
			if(pos==1){
				sprintf(nombre_elemento,"%s",linea);
			}else{
				if(pos==2){
					sprintf(tipo_elemento,"%s",linea);
				}else{
					if(pos==3){
						sprintf(longitud_elemento,"%s",linea);							
					}else{
						if(pos==4){
							//printf("\ttoken valor: %s\n",linea);
							sprintf(valor_elemento,"%s",linea);
						}
					}
				}
			}
			pos++;
			
		}
			
				
			
		
		nro_linea++;
		
    }
	
	fclose(pfTS);
	
	
}

void generarCodigo() {
	//printf("** Inicio generar codigo **\n\n");
    FILE *pfINT;
    char linea[30];
		
    //Abrir archivo intermedia.txt
    if(!(pfINT = fopen("intermedia.txt", "rt"))) {
         informeError("Error al abrir el archivo intermedia.txt, verifique los permisos de escritura.");
    }

	
	
    //Encabezado del sector de codigo
    fprintf(pfASM, "\n.CODE ;Comienzo de la zona de codigo\n");


    //Inicio codigo usuario
    fprintf(pfASM, "START: \t\t ;Código assembler resultante de compilar el programa fuente.\n");
    fprintf(pfASM, "\tmov AX,@DATA \t\t ;Inicializa el segmento de datos\n");
    fprintf(pfASM, "\tmov DS,AX\n");
    //fprintf(pfASM, "\tfinit\n\n");
	
    //Leer de archivo y generar assembler
    size_t lin;
    while(fgets(linea, 30, pfINT) != NULL) {
    	lin = strlen(linea)-1;
    	if (linea[lin] == '\n')     
    		linea[lin] = '\0';
        //printf("LINEA: %s FIN_DE_LINEA\n", linea);
        imprimirInstruccionPolaca(linea);
    }
	
	// verifico una vez mas
	int i=1;
	int salir=0;
	char aux[STR_VALUE];
	celda_actual++;	
	while(i<=cant_elementos_etiq && salir==0){
		//printf("\n%s\n",vec_etiquetas[i]);
		if(atoi(vec_etiquetas[i])==celda_actual){
			sprintf(aux,"_etiq%s",vec_etiquetas[i]); // armo string _etiq
			fprintf(pfASM, "%s:\n",aux);
			salir=1;
		}
		i++;
	}
	
    //debugP(topePila);
}


void imprimirInstruccionPolaca(char* linea){
	//printf("** Instruccion linea %s**\n",linea);

	char op1[STR_VALUE];
    char op2[STR_VALUE] = "";
    
	char* opp1;
    char* opp2;
	char aux[STR_VALUE]; // usada para las variables auxiliares @aux
	char opp_aux[STR_VALUE]; //usada solo para apilar
	char branch_aux[STR_VALUE];  // cuando leo branch guardo instruccion para ejecutarlo en el siguiente paso
	//char etiq[STR_VALUE];
	
	// Logica para los saltos	
	celda_actual++;		
	
	// verifico si llegue a la celda para agregar la etiqueta	
	int i=1;
	int salir=0;
	while(i<=cant_elementos_etiq && salir==0){
		if(atoi(vec_etiquetas[i])==celda_actual){
			sprintf(aux,"_etiq%s",vec_etiquetas[i]); // armo string _etiq
			fprintf(pfASM, "%s:\n",aux);
			salir=1;
		}
		i++;
	}
	
	/*if(topePilaSaltos>0){
		//printf("comparo %d = %d ?",atoi(pila_saltos[topePilaSaltos-1]),celda_actual);
		if(atoi(pila_saltos[topePilaSaltos-1])==celda_actual){
			sprintf(aux,"_etiq%s",desapilarPilaSaltos()); // armo string _etiq
			fprintf(pfASM, "%s:\n",aux);
		}		
	}*/
	
	// siempre despues de un branch viene una celda a la que salto.
	if(flag_leer_salto==1){
		//insertarEtiqueta(linea);
		fprintf(pfASM, "\t%s _etiq%s\n",branch_aux,linea); // armo instruccion
		flag_leer_salto=0;
		return;
	}
	
	
	//Siempre despues de un READ / WRITE viene un ID / CTE
	if(flag_write==1){
		fprintf(pfASM,"\t;WRITE\n");
		opp1=(char *) malloc(sizeof(char) * 31); 
		strcpy(opp1, obtenerTipoTS(linea));
		//printf("\t***Obtuve Tipo %s",opp1);
		if(strcmp(opp1,"CONST_INT")==0 || strcmp(opp1,"INTEGER")==0){
			if(strcmp(opp1,"INTEGER")==0){
				fprintf(pfASM,"\tDisplayInteger _%s 2\n",linea);
				fprintf(pfASM, "\tnewLine 1\n\n");    

			}else{
				fprintf(pfASM,"\tDisplayInteger %s 2\n",linea);
				fprintf(pfASM, "\tnewLine 1\n\n");    
			}
		}else{
			if(strcmp(opp1,"CONST_REAL")==0 || strcmp(opp1,"REAL")==0){
				if(strcmp(opp1,"REAL")==0){
					fprintf(pfASM,"\tDisplayFloat _%s 2\n",linea);
					fprintf(pfASM, "\tnewLine 1\n\n");

				}else{
					fprintf(pfASM,"\tDisplayFloat %s 2\n",linea);
					fprintf(pfASM, "\tnewLine 1\n\n");
				}
			}else{
				if(strcmp(opp1,"CONST_STR")==0 || strcmp(opp1,"STRING")==0){
					if(strcmp(opp1,"STRING")){
						fprintf(pfASM,"\tdisplayString _%s\n",linea);
						fprintf(pfASM, "\tnewLine 1\n\n");
					}else{
						fprintf(pfASM,"\tdisplayString %s\n",linea);
						fprintf(pfASM, "\tnewLine 1\n\n");
					}
				}
			}
		}
		
		flag_write=0;
		return;
	}
	
	//continuo leyendo instrucciones
	if(strcmp(linea,"WRITE") == 0){
		flag_write=1;
		return;
	}
	
	if(strcmp(linea,"+") == 0){
	
		fprintf(pfASM,"\t;SUMA\n");
		opp1=(char *) malloc(sizeof(char) * 31); 
		opp2=(char *) malloc(sizeof(char) * 31); 
		strcpy(opp1, sacarDePila());
		strcpy(opp2, sacarDePila());
		
		// no esta asi en el apunte pero lo dejo x las dudas
		fprintf(pfASM, "\tfld %s\n",opp1);
		fprintf(pfASM, "\tfld %s\n",opp2);
		fprintf(pfASM, "\tfadd\n");
		
		//fprintf(pfASM, "\tmov R1, %s\n",opp1);
		//fprintf(pfASM, "\tadd R1, %s\n",opp2);
		sprintf(aux,"@aux%d",cont_aux); // armo string @aux	
		fprintf(pfASM, "\tfstp %s\n",aux); 
		ponerEnPila(aux);
		cont_aux++;
		return;
					
	}
			
	if(strcmp(linea,"-") == 0){
		fprintf(pfASM,"\t;RESTA\n");
		opp1=(char *) malloc(sizeof(char) * 31); 
		opp2=(char *) malloc(sizeof(char) * 31); 
		strcpy(opp1, sacarDePila());
		strcpy(opp2, sacarDePila());
				
		fprintf(pfASM, "\tfld %s\n",opp1);
		fprintf(pfASM, "\tfld %s\n",opp2);
		fprintf(pfASM, "\tfsub\n");
		sprintf(aux,"@aux%d",cont_aux); // armo string @aux		
		fprintf(pfASM, "\tfstp %s\n",aux); 
		ponerEnPila(aux);
		cont_aux++;
		return;
	}
	
	if(strcmp(linea,"*")==0){
		fprintf(pfASM,"\t;MULTIPLICACION\n");
		opp1=(char *) malloc(sizeof(char) * 31); 
		opp2=(char *) malloc(sizeof(char) * 31); 
		strcpy(opp1, sacarDePila());
		strcpy(opp2, sacarDePila());
						
		fprintf(pfASM, "\tfld %s\n",opp1);
		fprintf(pfASM, "\tfld %s\n",opp2);
		fprintf(pfASM, "\tfmul\n");
		sprintf(aux,"@aux%d",cont_aux); // armo string @aux		
		fprintf(pfASM, "\tfstp %s\n",aux); 
		ponerEnPila(aux);
		cont_aux++;
		return;
	}
			
	if(strcmp(linea,"/")==0){
		fprintf(pfASM,"\t;DIVISION\n");
		opp1=(char *) malloc(sizeof(char) * 31); 
		opp2=(char *) malloc(sizeof(char) * 31); 
		strcpy(opp1, sacarDePila());
		strcpy(opp2, sacarDePila());
						
		fprintf(pfASM, "\tfld %s\n",opp1);
		fprintf(pfASM, "\tfld %s\n",opp2);
		fprintf(pfASM, "\tfdiv\n");
		sprintf(aux,"@aux%d",cont_aux); // armo string @aux		
		fprintf(pfASM, "\tfstp %s\n",aux); 
		ponerEnPila(aux);
		cont_aux++;
		return;  
	}			

	if(strcmp(linea,":=")==0){
	
		fprintf(pfASM,"\t;ASIGNACION\n");
		opp1=(char *) malloc(sizeof(char) * 31); 
		opp2=(char *) malloc(sizeof(char) * 31); 
		strcpy(opp1, sacarDePila());
		strcpy(opp2, sacarDePila());
		
		fprintf(pfASM, "\tfld %s\n",opp1);
		fprintf(pfASM, "\tfstp %s\n",opp2); 
		//fprintf(pfASM, "\t\nfmov\n");
		
		//fprintf(pfASM,"\tmov R1, %s\n",opp1);
		//fprintf(pfASM,"\tmov %s, R1\n",opp2);
		//fprintf(pfASM, "\tmov %s, %s\n", opp2, opp1); 
		//printf("\t\nmov %s, %s\n", opp2, opp1);	
		return;
	}

	if(strcmp(linea,"CMP")==0){
		fprintf(pfASM,"\t;CMP\n");
		opp1=(char *) malloc(sizeof(char) * 31); 
		opp2=(char *) malloc(sizeof(char) * 31); 
		strcpy(opp1, sacarDePila());
		strcpy(opp2, sacarDePila());
		
		fprintf(pfASM, "\tfld %s\n",opp1);
		fprintf(pfASM, "\tfld %s\n",opp2);  
		fprintf(pfASM, "\tfxch\n");		
		fprintf(pfASM, "\tfcomp\n");
		fprintf(pfASM, "\tfstsw ax\n");
		//fprintf(pfASM, "\tfwait\n");
		fprintf(pfASM, "\tffree st(0)\n");
		fprintf(pfASM, "\tsahf\n\n");                            
		return;
		           
	}
	
	if(strcmp(linea,"BI")==0){	
		//printf("ASM: Leo BI\n");
		strcpy(branch_aux,"JMP");
		flag_leer_salto=1;
		return;
	}
	if(strcmp(linea,"BEQ")==0){
		strcpy(branch_aux,"JE");
		flag_leer_salto=1;
		return;
		//fprintf(pfASM, "\tje %s\n",op1); //JE	Jump if Equal	salta si igual	A=B
	}
	if(strcmp(linea,"BNE")==0){
		strcpy(branch_aux,"JNE");
		flag_leer_salto=1;
		return;
		//fprintf(pfASM, "\tjne %s\n",op1);
	}
	if(strcmp(linea,"BLT")==0){
		strcpy(branch_aux,"JA");
		flag_leer_salto=1;
		return;
		//fprintf(pfASM, "\tjl %s\n",op1); //JL	Jump if Less	salta si menor	A<B (con signo)
	}
	if(strcmp(linea,"BLE")==0){
		strcpy(branch_aux,"JAE");
		flag_leer_salto=1;
		return;
		//fprintf(pfASM, "\tjle %s\n",op1); //JLE	Jump if Less or Equal	salta si menor o igual
	}
	if(strcmp(linea,"BGT")==0){
		strcpy(branch_aux,"JB");
		flag_leer_salto=1;
		return;
		//fprintf(pfASM, "\tjg %s\n",op1); //JG	Jump if Greater	salta si mayor	A>B (con signo)
	}                           
	if(strcmp(linea,"BGE")==0){
		strcpy(branch_aux,"JBE");
		flag_leer_salto=1;
		//fprintf(pfASM, "\tjge %s\n",op1);  //JGE	Jump if Greater or Equal	salta si mayor o igual	A>=B (con signo)  
	}else{ //apilo operando 
		//printf("poner en pila %s \n", linea);
		//poner_en_pila(&pila, linea, 255); //todo lo que sea operando lo apilo, para luego sacarDePila cuando llegue a operador
		strcpy(opp_aux,"_");
		strcat(opp_aux,linea);		
		ponerEnPila(opp_aux);//todo lo que sea operando lo apilo, para luego sacarDePila cuando llegue a operador

	}		
	
}


void generarFin(){
    //Fin de ejecución
    fprintf(pfASM, "\nTERMINAR: ;Fin de ejecución.\n");
    fprintf(pfASM, "\tmov ax, 4C00h ; termina la ejecución.\n");
    fprintf(pfASM, "\tint 21h; syscall\n");
    fprintf(pfASM, "\nEND START;final del archivo.");    
}

int informeError(char * error){
		printf("\n%s",error);
		getchar();
		exit(1);
}

void ponerEnPila(char * str)
{
    if(pLlena(topePila) == TRUE){
        printf("Error: Se excedio el tamano de la pila.\n");
        system ("Pause");
        exit (1);
    }
    

    char *aux = (char *) malloc(sizeof(char) * (strlen(str) + 1));     
	strcpy(aux, str);
	pilaASM[topePila] = aux;
	//free(aux);

	topePila++;
    //printf("\tponerEnPila en ASM -> %s\n",str);
        
}

char* sacarDePila()
{
    if(pVacia(topePila) == 0)
    {
        char * dato = pilaASM[topePila-1];
        topePila--; 
        //printf("\tsacarDePila en ASM -> %s\n",dato);
        return dato;      
    } else {
        printf("Error: La pila esta vacia.\n");
        system ("Pause");
        exit (1);
    }
}

void insertarEtiqueta(char * str)
{
	char *aux = (char *) malloc(sizeof(char) * (strlen(str) + 1));     
	strcpy(aux, str);
	
	//printf("\tInserto etiqueta nro. %s\n",aux);
	// verifico que no exista
	//for
	
	cant_elementos_etiq++;
	vec_etiquetas[cant_elementos_etiq] = aux;
	
}


int pVacia(int tope)
{
    if (tope-1 == -1){
        return TRUE;
    } 
    return FALSE;
}

int pLlena(int tope)
{
    if (tope-1 == TAM_PILA-1){
        return TRUE;
    } 
    return FALSE;
}

void debugP(int tope)
{
    int i,e;
    e=tope;
    printf("====== DEBUG PILA ======\n\n");
    printf("El tope de la pila es %d \n",tope);        
    printf("Lista de elementos: \n");           
    for (i=0; i<e;i++){
        printf("%d => %s\n",i,pilaASM[i]);      
    }                    
    printf("\n====== FIN DEBUG PILA ======\n\n");   
    
}

void cargarVectorEtiquetas(){

	FILE *pfINT;
    char linea[30];
		
    //Abrir archivo intermedia.txt
    if(!(pfINT = fopen("intermedia.txt", "rt"))) {
         informeError("Error al abrir el archivo intermedia.txt, verifique los permisos de escritura.");
    }
	
	
	size_t lin;
    while(fgets(linea, 30, pfINT) != NULL) {
    	lin = strlen(linea)-1;
    	if (linea[lin] == '\n')     
    		linea[lin] = '\0';
        //printf("leo LINEA: %s \n", linea);
		
		if(flag_leer_salto==1){
			//printf("ENTRE A INTERTAR ETIQUETA\n");
			insertarEtiqueta(linea);
			flag_leer_salto=0;
		}else{

			if(strcmp(linea,"BI")==0){			
				flag_leer_salto=1;
			}
			if(strcmp(linea,"BEQ")==0){		
				flag_leer_salto=1;
			}
			if(strcmp(linea,"BNE")==0){		
				flag_leer_salto=1;	
			}
			if(strcmp(linea,"BLT")==0){
				flag_leer_salto=1;
			}
			if(strcmp(linea,"BLE")==0){		
				flag_leer_salto=1;
				
			}
			if(strcmp(linea,"BGT")==0){		
				flag_leer_salto=1;	
			}                           
			if(strcmp(linea,"BGE")==0){		
				flag_leer_salto=1;
			}
		}
		
        
    }
	//printf("** Termino de leer etiquetas **\n\n");
	fclose(pfINT);
	return;
	
}

char* obtenerTipoTS(char* nombre_elemento){
	FILE *pfTS;
	char* token;
	char* aux;
	char linea[100];
	int encontro = 0;
	int nro_linea=1;
	
	if(!(pfTS = fopen("ts2.txt", "r+"))) {
         informeError("Error al abrir el archivo ts.txt, verifique los permisos de escritura.");
    }
	
	int pos=1; //1=nombre/2=tipo/3=longitud/4=valor
	size_t lin;
	aux=(char *) malloc(sizeof(char) * 31); 
	while(fgets(linea, 30, pfTS) != NULL) {
	
		lin = strlen(linea)-1;
    	if(linea[lin] == '\n'){linea[lin] = '\0';}
		
		if(pos==6){pos=1;} // reinicio
		
		if(pos==1)
		{
			if(strcmp(linea,nombre_elemento)==0)
			{
				encontro=1;
			}					
		}
		else
		{
			if(pos==2)
			{
				if(encontro==1)
				{
					//printf("\t****Se obtuvo tipo: %s\n",linea);
					sprintf(aux,"%s",linea);
					return aux;
				}
			}
		}			
		pos++;							
		
		nro_linea++;
    }
	
	
	fclose(pfTS);
	return "";


}


