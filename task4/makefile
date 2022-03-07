run: cal
	./cal

.PHONY : run test

test: cal
	./cal < test

cal: lex.yy.c y.tab.c
	gcc -o $@ $^

y.tab.c: cal.y
	yacc -d -Wyacc $<

lex.yy.c: cal.l
	flex $<