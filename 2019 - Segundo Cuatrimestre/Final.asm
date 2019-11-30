;
;ARCHIVO FINAL.ASM
;

INCLUDE macros2.asm		 ;incluye macros
INCLUDE number.asm		 ;incluye el asm para impresion de numeros

.MODEL LARGE ; tipo del modelo de memoria usado.
.386
.STACK 200h ; bytes en el stack
	
.DATA ; comienzo de la zona de datos.
	TRUE equ 1
	FALSE equ 0
	MAXTEXTSIZE equ 200
	R1 dd ?
	@aux1 dd ?
	@aux2 dd ?
	@aux3 dd ?
	@aux4 dd ?
	@aux5 dd ?
	@aux6 dd ?
	@aux7 dd ?
	@aux8 dd ?
	@aux9 dd ?
	@aux10 dd ?
	@aux11 dd ?
	@aux12 dd ?
	@aux13 dd ?
	@aux14 dd ?
	@aux15 dd ?

.CODE ;Comienzo de la zona de codigo
START: 		 ;Código assembler resultante de compilar el programa fuente.
	mov AX,@DATA 		 ;Inicializa el segmento de datos
	mov DS,AX
	;ASIGNACION
	fld _2
	fstp _valE
	;ASIGNACION
	fld _"Hola mundo"
	fstp _valS
	;ASIGNACION
	fld _2.5
	fstp _valR
	;ASIGNACION
	fld _1
	fstp _a2
	;DIVISION
	fld _1
	fld _2
	fdiv
	fstp @aux1
	;ASIGNACION
	fld @aux1
	fstp _var1
	;ASIGNACION
	fld _valE
	fstp _mod0
	;ASIGNACION
	fld _valE
	fstp _mod1
	;DIVISION
	fld _mod1
	fld _mod0
	fdiv
	fstp @aux2
	;MULTIPLICACION
	fld @aux2
	fld _mod1
	fmul
	fstp @aux3
	;RESTA
	fld @aux3
	fld _mod0
	fsub
	fstp @aux4
	;ASIGNACION
	fld @aux4
	fstp _var1

TERMINAR: ;Fin de ejecución.
	mov ax, 4C00h ; termina la ejecución.
	int 21h; syscall

END START;final del archivo.