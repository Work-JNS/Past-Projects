#include <stdio.h>
#include <stdlib.h>

int main(){

char** x = malloc(sizeof(char*)*3);
    x[0] = "Hello ";
    x[1] = "Dum";
    x[2] = "Dum";
    
    printf("%s%s%s",x[0],x[1],x[2]);
    free(x);
    return 0;
}
