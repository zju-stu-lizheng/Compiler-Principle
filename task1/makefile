run: w-s
	./upper hello.c

w-s: lex.yy.c
	gcc -o $@ $^

lex.yy.c: file.l
	flex $<