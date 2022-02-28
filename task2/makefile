run: w-s
    ./w-s ./hello.c

w-s: lex.yy.c
    gcc -o $@ $<

lex.yy.c: upper.l
    flex $<