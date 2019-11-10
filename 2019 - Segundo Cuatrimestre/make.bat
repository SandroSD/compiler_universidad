bison -dyv Sintactico.y
pause
flex Lexico.l
pause
gcc lex.yy.c y.tab.c punto_c/ts.c punto_c/asm.c -o segunda.exe
pause
echo Ejecutando pruebas!
segunda.exe Pruebas.txt
pause
