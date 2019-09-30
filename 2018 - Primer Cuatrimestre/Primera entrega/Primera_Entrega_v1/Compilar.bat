C:\GnuWin32\bin\flex Lexico.l
C:\GnuWin32\bin\bison -dyv Sintactico_v2.y
C:\MinGW\bin\gcc.exe lex.yy.c y.tab.c -o ejecutar.exe

echo Ejectuando pruebas OK
ejecutar.exe test.txt
pause

echo Ejecutando pruebas NOK
ejecutar.exe PruebasFail.txt
pause
