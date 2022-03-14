#include<stdio.h>
/* Comment-1
To test reserved: if else int double
*/

// Comment-2
// To test reserved: if else int double

// Comment-3
/* ---------if------- // -----if---------*/
// /* ------if----------------if---------*/
// To test nested comments

int main(){
    long long m;        //test for special case: two key words are linked together
    int iff = 1;        //test for special case: an identifier contains a key word
    printf("Hello World!if and else");
    if(iff!=0){printf("if 1");}else{printf("else 2");} //test for special case: quote expressions in one line
    return 0;
}
