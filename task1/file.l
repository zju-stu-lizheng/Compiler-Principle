%option noyywrap
%{
int numChars = 0, numWords = 0, numLines = 0;
%}

WORD ([a-zA-Z0-9]+)
STRING ([^ \t\n\r]+)

%%
{WORD}        { numWords++; numChars += yyleng;  }
\n            { numLines++;}
{STRING}      { numChars += 1; }
.             { }
%%

extern FILE* yyin;

int main(int argc,char**argv) {
    if (argc > 1) {
        /*open the file*/
        if (!(yyin = fopen(argv[1], "r"))) {
            perror(argv[1]);
            return 1;
        }
        /*do the lex*/
        yylex();
    }
    /*print the result*/
    printf("\nChars\tWords\tLines\n");
    printf("%d\t%d\t%d\n", numChars, numWords, numLines);
    return 0;
}
