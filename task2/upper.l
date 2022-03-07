%{
#include <ctype.h>
%}
%option noyywrap

COMMENT		"/*"([^*]|"*"[^"*""/"])*"*"*"*/"
COMMENT2    "//"[^\n]*
STRING      \"([^\"])*\"
KEY         (auto|break|case|char|const|continue|default|do|double|else|enum|extern|float|for|goto|if|inline|int|long|register|restrict|return|short|signed|sizeof|static|struct|switch|typedef|union|unsigned|void|volatile|while)
WORD        ({KEY}[a-zA-Z0-9_]+)|([a-zA-Z0-9_]+{KEY})
NOT_KEY     {COMMENT}|{COMMENT2}|{STRING}|{WORD}

%%
{NOT_KEY}    {printf("%s", yytext);}
{KEY}        { 
        for (size_t i = 0; i < yyleng; ++i) {
            if (islower(yytext[i])) {
                yytext[i] = toupper(yytext[i]); /*transfer to upper case*/
            }
        }
        printf("%s", yytext);
    }
.       {printf("%s", yytext);}
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
    return 0;
}