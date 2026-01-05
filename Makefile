compiler:
	flex scanner.l
	bison -d parser.y
	gcc lex.yy.c parser.tab.c -o compiler

clean:
	rm -f compiler lex.yy.c parser.tab.c parser.tab.h
