run: cal
	./cal

cal: lex.yy.c y.tab.c
	gcc -o $@ $^

y.tab.c: cal.y
	yacc -d $<

lex.yy.c: cal.l
	flex $<