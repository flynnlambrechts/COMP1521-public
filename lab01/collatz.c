#include <stdio.h>
#include <stdlib.h>

void collatz(int x);


int main(int argc, char *argv[])
{
	// (void) argc, (void) argv; // keep the compiler quiet, should be removed
	collatz(atoi(argv[1]));
	return EXIT_SUCCESS;
}

void collatz(int x) {
	printf("%d\n", x);
	if (x == 1) {

		return;
	} else if (x % 2 == 0) {
		collatz(x/2);
	} else {
		collatz(3*x + 1);
	}
	

}