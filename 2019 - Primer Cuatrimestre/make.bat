bison -dyv Sintactico.y
pause
flex Lexico.l
pause
gcc.exe lex.yy.c y.tab.c -o primera.exe
pause
echo Ejecutando pruebas!
primera.exe Pruebas.txt
pause
