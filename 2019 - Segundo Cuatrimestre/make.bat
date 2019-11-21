bison -dyv Sintactico.y
pause
flex Lexico.l
pause
gcc lex.yy.c y.tab.c punto_c/ts.c punto_c/asm.c -o Grupo05.exe
pause
echo Ejecutando pruebas!
Grupo05.exe Pruebas.txt
pause
