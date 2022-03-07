%{
#include <stdio.h>
#include "y.tab.h"


%}

%option noyywrap

%%
[0-9]+"."[0-9]+ {
    yylval.value.fv = atof(yytext);  /* <TYPE_FLOAT,yylval> */
    yylval.value_type = TYPE_FLOAT;
    return NUMBER;
}

[0-9]+ {
    yylval.value.iv = atoi(yytext);  /* <TYPE_INTEGER,yylval> */
    yylval.value_type = TYPE_INTEGER;
    return NUMBER;
}


[^ \t\n] {
    return yytext[0];       /* + / -  */
}

\n {
    return yytext[0];       /* <\n> */
}

<<EOF>> {
    return 0;
}

. {}

%%