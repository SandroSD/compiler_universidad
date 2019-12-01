;
;ARCHIVO FINAL.ASM
;

INCLUDE macros2.asm		 ;incluye macros
INCLUDE number.asm		 ;incluye el asm para impresion de numeros

.MODEL LARGE ; tipo del modelo de memoria usado.
.386
.STACK 200h ; bytes en el stack
	
.DATA		 ; comienzo de la zona de datos.
	TRUE equ 1
	FALSE equ 0
	MAXTEXTSIZE equ 30
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
	_var1 dd 0
	_var2 dd 0
	_var3 dd 0
	_var4 dd 0.0
	_a dd 0
	_a2 dd 0
	_var7 dd 0
	_valE dd 0.0
	&cte2 dd 2
	_valR dd 0.0
	&cte4 dd 2.5
	&cte5 dd 1
	&cte6 dd 10
	&cte7 dd 9
	&cte8 dd 5
	&cte9 dd 8
	_mod0 dd 0.0
	_mod1 dd 0.0

.CODE ;Comienzo de la zona de codigo
START: 		 ;Código assembler resultante de compilar el programa fuente.
	mov AX,@DATA 		 ;Inicializa el segmento de datos
	mov DS,AX
	;ASIGNACION CTE NOMBRE
	fld &cte2
	fld _valE
	;ASIGNACION CTE NOMBRE
	fld &cte4
	fld _valR
	;ASIGNACION
	fld &cte5
	fstp _a2
	;DIVISION
	fld &cte5
	fld &cte2
	fdiv
	fstp @aux1
	;ASIGNACION
	fld @aux1
	fstp _var1
	;CMP
	fld &cte7
	fld &cte6
	fxch
	fcomp
	fstsw ax
	ffree st(0)
	sahf

	JAE _etiq25
	;SUMA
	fld &cte5
	fld &cte8
	fadd
	fstp @aux2
	;ASIGNACION
	fld @aux2
	fstp _var1
_etiq25:
	;CMP
	fld &cte7
	fld &cte9
	fxch
	fcomp
	fstsw ax
	ffree st(0)
	sahf

	JAE _etiq37
	;SUMA
	fld &cte5
	fld &cte8
	fadd
	fstp @aux3
	;ASIGNACION
	fld @aux3
	fstp _var1
	JMP _etiq40
_etiq37:
	;ASIGNACION
	fld &cte5
	fstp _a
_etiq40:
	;CMP
	fld &cte7
	fld &cte9
	fxch
	fcomp
	fstsw ax
	ffree st(0)
	sahf

	JB _etiq50
	;CMP
	fld &cte6
	fld &cte7
	fxch
	fcomp
	fstsw ax
	ffree st(0)
	sahf

	JAE _etiq57
_etiq50:
	;SUMA
	fld &cte5
	fld &cte8
	fadd
	fstp @aux4
	;ASIGNACION
	fld @aux4
	fstp _var1
	JMP _etiq62
_etiq57:
	;SUMA
	fld &cte5
	fld &cte8
	fadd
	fstp @aux5
	;ASIGNACION
	fld @aux5
	fstp _var1
_etiq62:
	;CMP
	fld &cte7
	fld &cte9
	fxch
	fcomp
	fstsw ax
	ffree st(0)
	sahf

	JAE _etiq79
	;CMP
	fld &cte6
	fld &cte7
	fxch
	fcomp
	fstsw ax
	ffree st(0)
	sahf

	JAE _etiq79
	;SUMA
	fld &cte5
	fld &cte8
	fadd
	fstp @aux6
	;ASIGNACION
	fld @aux6
	fstp _var1
	JMP _etiq84
_etiq79:
	;SUMA
	fld &cte5
	fld &cte8
	fadd
	fstp @aux7
	;ASIGNACION
	fld @aux7
	fstp _var1
_etiq84:

TERMINAR: ;Fin de ejecución.
	mov ax, 4C00h ; termina la ejecución.
	int 21h; syscall

END START;final del archivo.