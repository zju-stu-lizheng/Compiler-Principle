%{
#include <stdio.h>
#include <string.h>
#include <math.h>


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

%code requires{
typedef enum {
    TYPE_INTEGER,
    TYPE_FLOAT
} value_type_t;

typedef struct {
    union{
        int iv;
        float fv;
    } value;
    value_type_t value_type;
} type;

#define YYSTYPE type
}

%%
command: exp1{}

exp1: exp1 '\n' exp{
    if($3.value_type == TYPE_INTEGER){
        printf("%d\n",$3.value.iv);
    }else{
        printf("%f\n",$3.value.fv);
    }
}
| exp{
    if($1.value_type == TYPE_INTEGER){
        printf("%d\n",$1.value.iv);
    }else{
        printf("%f\n",$1.value.fv);
    }
}

exp: exp '+' term {
    if($1.value_type == TYPE_INTEGER && $3.value_type == TYPE_INTEGER){
        $$.value_type = TYPE_INTEGER;
        $$.value.iv = $1.value.iv + $3.value.iv;
    }else if($1.value_type == TYPE_INTEGER && $3.value_type == TYPE_FLOAT){
        $$.value_type = TYPE_FLOAT;
        $$.value.fv = $1.value.iv + $3.value.fv;
    }else if($1.value_type == TYPE_FLOAT && $3.value_type == TYPE_INTEGER){
        $$.value_type = TYPE_FLOAT;
        $$.value.fv = $1.value.fv + $3.value.iv;
    }else{
        $$.value_type = TYPE_FLOAT;
        $$.value.fv = $1.value.fv + $3.value.fv;
    }
}
| exp '-' term {
    if($1.value_type == TYPE_INTEGER && $3.value_type == TYPE_INTEGER){
        $$.value_type = TYPE_INTEGER;
        $$.value.iv = $1.value.iv - $3.value.iv;
    }else if($1.value_type == TYPE_INTEGER && $3.value_type == TYPE_FLOAT){
        $$.value_type = TYPE_FLOAT;
        $$.value.fv = $1.value.iv - $3.value.fv;
    }else if($1.value_type == TYPE_FLOAT && $3.value_type == TYPE_INTEGER){
        $$.value_type = TYPE_FLOAT;
        $$.value.fv = $1.value.fv - $3.value.iv;
    }else{
        $$.value_type = TYPE_FLOAT;
        $$.value.fv = $1.value.fv - $3.value.fv;
    }
}
| term {
    if($1.value_type == TYPE_INTEGER){
        $$.value_type = TYPE_INTEGER;
        $$.value.iv = $1.value.iv;
    }else{
        $$.value_type = TYPE_FLOAT;
        $$.value.fv = $1.value.fv;
    }
}

term: term '*' num {
        if($1.value_type == TYPE_INTEGER && $3.value_type == TYPE_INTEGER){
        $$.value_type = TYPE_INTEGER;
        $$.value.iv = $1.value.iv * $3.value.iv;
    }else if($1.value_type == TYPE_INTEGER && $3.value_type == TYPE_FLOAT){
        $$.value_type = TYPE_FLOAT;
        $$.value.fv = $1.value.iv * $3.value.fv;
    }else if($1.value_type == TYPE_FLOAT && $3.value_type == TYPE_INTEGER){
        $$.value_type = TYPE_FLOAT;
        $$.value.fv = $1.value.fv * $3.value.iv;
    }else{
        $$.value_type = TYPE_FLOAT;
        $$.value.fv = $1.value.fv * $3.value.fv;
    }
}
| term '/' num {
    if($1.value_type == TYPE_INTEGER && $3.value_type == TYPE_INTEGER){
        $$.value_type = TYPE_INTEGER;
        $$.value.iv = $1.value.iv / $3.value.iv;
    }else if($1.value_type == TYPE_INTEGER && $3.value_type == TYPE_FLOAT){
        $$.value_type = TYPE_FLOAT;
        $$.value.fv = $1.value.iv / $3.value.fv;
    }else if($1.value_type == TYPE_FLOAT && $3.value_type == TYPE_INTEGER){
        $$.value_type = TYPE_FLOAT;
        $$.value.fv = $1.value.fv / $3.value.iv;
    }else{
        $$.value_type = TYPE_FLOAT;
        $$.value.fv = $1.value.fv / $3.value.fv;
    }
}
| num {
    if($1.value_type == TYPE_INTEGER){
        $$.value_type = TYPE_INTEGER;
        $$.value.iv = $1.value.iv;
    }else{
        $$.value_type = TYPE_FLOAT;
        $$.value.fv = $1.value.fv;
    }
}

num: NUMBER {
    if($1.value_type == TYPE_INTEGER){
        $$.value_type = TYPE_INTEGER;
        $$.value.iv = $1.value.iv;
    }else{
        $$.value_type = TYPE_FLOAT;
        $$.value.fv = $1.value.fv;
    }
}
| '(' exp ')' {
    if($2.value_type == TYPE_INTEGER){
        $$.value_type = TYPE_INTEGER;
        $$.value.iv = $2.value.iv;
    }else{
        $$.value_type = TYPE_FLOAT;
        $$.value.fv = $2.value.fv;
    }
}
| num '^' num {
    if($1.value_type == TYPE_INTEGER && $3.value_type == TYPE_INTEGER){
        $$.value_type = TYPE_INTEGER;
        $$.value.iv = pow($1.value.iv,$3.value.iv);
    }else if($1.value_type == TYPE_INTEGER && $3.value_type == TYPE_FLOAT){
        $$.value_type = TYPE_FLOAT;
        $$.value.fv = pow($1.value.iv,$3.value.fv);
    }else if($1.value_type == TYPE_FLOAT && $3.value_type == TYPE_INTEGER){
        $$.value_type = TYPE_FLOAT;
        $$.value.fv = pow($1.value.fv,$3.value.iv);
    }else{
        $$.value_type = TYPE_FLOAT;
        $$.value.fv = pow($1.value.fv,$3.value.fv);
    }
}


%%