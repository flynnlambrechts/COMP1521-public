#include <stdio.h>
#include <stdlib.h>
#define X 0

int main(int argc, char* argv[]) {
	int sum = 0;
	for (int i = X; i < argc; i++) {
		sum += atoi(argv[i]);
	}
	printf("sum of command-line arguments = %d\n", sum);
	return 0;
}
