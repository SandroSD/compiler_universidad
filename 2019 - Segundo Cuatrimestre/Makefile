all: compilador

compilador.tab.c compilador.tab.h: Sintactico.y
	bison -dyv Sintactico.y

lex.yy.c: Lexico.l compilador.tab.h
	flex Lexico.l

compilar: lex.yy.c compilador.tab.c compilador.tab.h
	gcc -o Grupo05.exe lex.yy.c y.tab.c
probar: compilar
	./Grupo05.exe Pruebas.txt
clean:
	rm Grupo05.exe lex.yy.c 

