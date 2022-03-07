.PHONY : run clean

run: w-s
	./w-s test

w-s: lex.yy.c
	gcc -o $@ $<

lex.yy.c: file.l
	flex $<

clean: 
	rm -rf lex.yy.c w-s
