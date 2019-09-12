all: compilador

compilador.tab.c compilador.tab.h: Sintactico.y
	bison -dyv Sintactico.y

lex.yy.c: Lexico.l compilador.tab.h
	flex Lexico.l

compilar: lex.yy.c compilador.tab.c compilador.tab.h
	gcc -o compilador.exe lex.yy.c y.tab.c
probar: compilar
	./compilador.exe Pruebas.txt
clean:
	rm compilador.exe lex.yy.c 

