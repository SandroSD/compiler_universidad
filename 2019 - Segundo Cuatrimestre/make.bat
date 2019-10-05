bison -dyv Sintactico.y
pause
flex Lexico.l
pause
gcc lex.yy.c y.tab.c punto_c/ts.c -o primera.exe
pause
echo Ejecutando pruebas!
primera.exe Pruebas1.txt
pause
