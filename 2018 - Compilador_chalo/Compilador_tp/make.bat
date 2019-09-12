bison -dyv sintactico.y
pause
flex lexico.l
pause
gcc.exe simbolos.c lex.yy.c y.tab.c -o primera.exe
pause
echo Ejecutando pruebas!
primera.exe Pruebas.txt
pause
