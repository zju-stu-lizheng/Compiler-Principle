run: w-s
    ./w-s ./text

w-s: lex.yy.c
    gcc -o $@ $<

lex.yy.c: file.l
    flex $<