;
;ARCHIVO FINAL.ASM
;

INCLUDE macros2.asm      ;incluye macros
INCLUDE number.asm       ;incluye el asm para impresion de numeros

.MODEL LARGE ; tipo del modelo de memoria usado.
.386
.STACK 200h ; bytes en el stack
    
.DATA        ; comienzo de la zona de datos.
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
    _valE dd 0
    _2 dd 2
    _valS dd 0
    _Hola db "Hola mundo", '$', 18 dup(?)
    _valR dd 0
    _2_5 dd 2.5
    _1 dd 1

.CODE ;Comienzo de la zona de codigo
START:       ;C?digo assembler resultante de compilar el programa fuente.
    mov AX,@DATA         ;Inicializa el segmento de datos
    mov DS,AX
    ;ASIGNACION
    fld _2
    fstp _valE
    ;ASIGNACION
    fld _Hola
    fstp _valS
    ;ASIGNACION
    fld _2_5
    fstp _valR
    ;ASIGNACION
    fld _1
    fstp _a2

TERMINAR: ;Fin de ejecuci?n.
    mov ax, 4C00h ; termina la ejecuci?n.
    int 21h; syscall

END START;final del archivo.