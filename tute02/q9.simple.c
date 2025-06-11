// Simple factorial calculator - without error checking

#include <stdio.h>

int main(void) {
	int n;
	printf("n  = ");
	scanf("%d", &n);

	int fac = 1;
	int i = 1;
loop_start:
	if (i > n)
		goto loop_end;
	fac *= i;
	i++;
	goto loop_start;
loop_end:
	printf("n! = %d\n", fac);
	return 0;
}