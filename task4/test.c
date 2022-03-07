#include <stdio.h>
typedef struct {
    union{
        int integer_value;
        float float_value;
    } value;
} type;

int main(){
    type test1;
    test1.value.float_value  = 1.5;
    type test2;
    test2.value.integer_value = 2;
    printf("%d,%f\n",test2.value.integer_value,test1.value.float_value);
    return 0;
}