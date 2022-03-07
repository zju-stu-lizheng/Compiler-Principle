%{
#include <stdio.h>
#include <string.h>

//在lex.yy.c里定义，会被yyparse()调用。在此声明消除编译和链接错误。
extern int yylex(void); 

// 在此声明，消除yacc生成代码时的告警
extern int yyparse(void); 

// 该函数在y.tab.c里会被调用，需要在此定义
void yyerror(const char *s)
{
        printf("[error] %s\n", s);
}

int main()
{
    yyparse();
    return 0;
}
%}

%token NUMBER

%%
command: exp1{}

exp1: exp1 '\n' exp{
    printf("%d\n",$3);
}
| exp{
    printf("%d\n",$1);
}

exp: exp '+' term {$$ = $1+$3;}
| exp '-' term {$$ = $1-$3;}
| term {$$ = $1;}

term: term '*' num {$$ = $1*$3;}
| term '/' num {$$ = $1/$3;}
| num {$$ = $1;}

num: NUMBER {$$ = $1;}
| '(' exp ')' {$$ = $2;}


%%