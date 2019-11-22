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
	;ASIGNACION
	fld _DIV
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
	fstp @aux1
	;MULTIPLICACION
	fld @aux1
	fld _mod1
	fmul
	fstp @aux2
	;RESTA
	fld @aux2
	fld _mod0
	fsub
	fstp @aux3
	;ASIGNACION
	fld @aux3
	fstp _var1
	;CMP
	fld _9
	fld _10
	fxch
	fcomp
	fstsw ax
	ffree st(0)
	sahf

	JAE _etiq43
	;SUMA
	fld _1
	fld _5
	fadd
	fstp @aux4
	;ASIGNACION
	fld @aux4
	fstp _var1
_etiq43:
	;CMP
	fld _9
	fld _8
	fxch
	fcomp
	fstsw ax
	ffree st(0)
	sahf

	JAE _etiq55
	;SUMA
	fld _1
	fld _5
	fadd
	fstp @aux5
	;ASIGNACION
	fld @aux5
	fstp _var1
	JMP _etiq58
_etiq55:
	;ASIGNACION
	fld _1
	fstp _a
_etiq58:
	;CMP
	fld _9
	fld _8
	fxch
	fcomp
	fstsw ax
	ffree st(0)
	sahf

	JB _etiq68
	;CMP
	fld _10
	fld _9
	fxch
	fcomp
	fstsw ax
	ffree st(0)
	sahf

	JAE _etiq75
_etiq68:
	;SUMA
	fld _1
	fld _5
	fadd
	fstp @aux6
	;ASIGNACION
	fld @aux6
	fstp _var1
	JMP _etiq80
_etiq75:
	;SUMA
	fld _1
	fld _5
	fadd
	fstp @aux7
	;ASIGNACION
	fld @aux7
	fstp _var1
_etiq80:
	;CMP
	fld _9
	fld _8
	fxch
	fcomp
	fstsw ax
	ffree st(0)
	sahf

	JAE _etiq97
	;CMP
	fld _10
	fld _9
	fxch
	fcomp
	fstsw ax
	ffree st(0)
	sahf

	JAE _etiq97
	;SUMA
	fld _1
	fld _5
	fadd
	fstp @aux8
	;ASIGNACION
	fld @aux8
	fstp _var1
	JMP _etiq102
_etiq97:
	;SUMA
	fld _1
	fld _5
	fadd
	fstp @aux9
	;ASIGNACION
	fld @aux9
	fstp _var1
_etiq102:
	;ASIGNACION
	fld _20
	fstp _c
	;PRINT
	displayString _"hola mundo"
	newLine 1


TERMINAR: ;Fin de ejecución.
	mov ax, 4C00h ; termina la ejecución.
	int 21h; syscall

END START;final del archivo.