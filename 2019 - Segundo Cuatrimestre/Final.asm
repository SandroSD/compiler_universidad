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
	_valS dd 0.0
	&cte4 db "Hola mundo", '$', 18 dup(?)
	_valR dd 0.0
	&cte6 dd 2.5
	&cte7 dd 1
	&cte8 dd 10
	&cte9 dd 9
	&cte10 dd 5
	&cte11 dd 8
	_c dd 0.0
	&cte13 dd 20
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
	fld _valS
	;ASIGNACION CTE NOMBRE
	fld &cte6
	fld _valR
	;ASIGNACION
	fld &cte7
	fstp _a2
	;DIVISION
	fld &cte7
	fld &cte2
	fdiv
	fstp @aux1
	;ASIGNACION
	fld @aux1
	fstp _var1
	;CMP
	fld &cte9
	fld &cte8
	fxch
	fcomp
	fstsw ax
	ffree st(0)
	sahf

	JAE _etiq28
	;SUMA
	fld &cte7
	fld &cte10
	fadd
	fstp @aux2
	;ASIGNACION
	fld @aux2
	fstp _var1
_etiq28:
	;CMP
	fld &cte9
	fld &cte11
	fxch
	fcomp
	fstsw ax
	ffree st(0)
	sahf

	JAE _etiq40
	;SUMA
	fld &cte7
	fld &cte10
	fadd
	fstp @aux3
	;ASIGNACION
	fld @aux3
	fstp _var1
	JMP _etiq43
_etiq40:
	;ASIGNACION
	fld &cte7
	fstp _a
_etiq43:
	;CMP
	fld &cte9
	fld &cte11
	fxch
	fcomp
	fstsw ax
	ffree st(0)
	sahf

	JB _etiq53
	;CMP
	fld &cte8
	fld &cte9
	fxch
	fcomp
	fstsw ax
	ffree st(0)
	sahf

	JAE _etiq60
_etiq53:
	;SUMA
	fld &cte7
	fld &cte10
	fadd
	fstp @aux4
	;ASIGNACION
	fld @aux4
	fstp _var1
	JMP _etiq65
_etiq60:
	;SUMA
	fld &cte7
	fld &cte10
	fadd
	fstp @aux5
	;ASIGNACION
	fld @aux5
	fstp _var1
_etiq65:
	;CMP
	fld &cte9
	fld &cte11
	fxch
	fcomp
	fstsw ax
	ffree st(0)
	sahf

	JAE _etiq82
	;CMP
	fld &cte8
	fld &cte9
	fxch
	fcomp
	fstsw ax
	ffree st(0)
	sahf

	JAE _etiq82
	;SUMA
	fld &cte7
	fld &cte10
	fadd
	fstp @aux6
	;ASIGNACION
	fld @aux6
	fstp _var1
	JMP _etiq87
_etiq82:
	;SUMA
	fld &cte7
	fld &cte10
	fadd
	fstp @aux7
	;ASIGNACION
	fld @aux7
	fstp _var1
_etiq87:
	;ASIGNACION
	fld &cte13
	fstp _c

TERMINAR: ;Fin de ejecución.
	mov ax, 4C00h ; termina la ejecución.
	int 21h; syscall

END START;final del archivo.