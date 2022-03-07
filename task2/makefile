.PHONY : run clean

run: upper
	./upper hello.c

upper: lex.yy.c
	gcc -o $@ $^

lex.yy.c: upper.l
	flex $<

clean: 
	rm -rf upper lex.yy.c