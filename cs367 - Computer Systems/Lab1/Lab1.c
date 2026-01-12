#include <stdio.h>
int main(){

	int c[] = {1, 0, 2, 4, 3};
	printf("%d", *(&c[4]));
}
