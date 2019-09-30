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
	_i dd ?
	_b dd ?
	_a dd ?
	_cadena db MAXTEXTSIZE dup(?), '$'
	_s db MAXTEXTSIZE dup(?), '$'
	_v dd ?
	_1 dd 1
	_8 dd 8
	_5 dd 5
	_2 dd 2
	_cteStr1 db "comienzo de Programa", '$', 22 dup(?)
	_4 dd 4
	_cteStr2 db "IF Afirmativo", '$', 15 dup(?)
	_30 dd 30
	_cteStr3 db "Fin de Programa", '$', 17 dup(?)

.CODE ;Comienzo de la zona de codigo
START: 		 ;Código assembler resultante de compilar el programa fuente.
	mov AX,@DATA 		 ;Inicializa el segmento de datos
	mov DS,AX
	;ASIGNACION
	fld _1
	fstp _i
	;ASIGNACION
	fld _1
	fstp _b
	;SUMA
	fld _5
	fld _8
	fadd
	fstp @aux1
	;SUMA
	fld _2
	fld @aux1
	fadd
	fstp @aux2
	;ASIGNACION
	fld @aux2
	fstp _i
	;SUMA
	fld _5
	fld _8
	fadd
	fstp @aux3
	;SUMA
	fld _2
	fld @aux3
	fadd
	fstp @aux4
	;ASIGNACION
	fld @aux4
	fstp _i
	;SUMA
	fld _5
	fld _8
	fadd
	fstp @aux5
	;SUMA
	fld _2
	fld @aux5
	fadd
	fstp @aux6
	;ASIGNACION
	fld @aux6
	fstp _b
	;WRITE
	displayString _cteStr1
	newLine 1

	;CMP
	fld _4
	fld _v
	fxch
	fcomp
	fstsw ax
	ffree st(0)
	sahf

	JNE _etiq43
	JMP _etiq37
_etiq37:
	;WRITE
	displayString _cteStr2
	newLine 1

	;WRITE
	DisplayInteger _i 2
	newLine 1

	JMP _etiq43
_etiq43:
	;CMP
	fld _30
	fld _i
	fxch
	fcomp
	fstsw ax
	ffree st(0)
	sahf

	JBE _etiq59
	JMP _etiq50
_etiq50:
	;WRITE
	DisplayInteger _i 2
	newLine 1

	;SUMA
	fld _1
	fld _i
	fadd
	fstp @aux7
	;ASIGNACION
	fld @aux7
	fstp _i
	JMP _etiq43
_etiq59:
	;CMP
	fld _2
	fld _a
	fxch
	fcomp
	fstsw ax
	ffree st(0)
	sahf

	JA _etiq76
	JMP _etiq66
_etiq66:
	;CMP
	fld _b
	fld _a
	fxch
	fcomp
	fstsw ax
	ffree st(0)
	sahf

	JB _etiq76
	JMP _etiq73
_etiq73:
	JMP _etiq77
_etiq76:
_etiq77:
	;WRITE
	displayString _cteStr3
	newLine 1


TERMINAR: ;Fin de ejecución.
	mov ax, 4C00h ; termina la ejecución.
	int 21h; syscall

END START;final del archivo.