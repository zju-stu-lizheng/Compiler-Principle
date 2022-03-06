run: upper
	./upper hello.c

upper: lex.yy.c
	gcc -o $@ $^

lex.yy.c: upper.l
	flex $<