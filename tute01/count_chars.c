#include <stdio.h>

int main() {
	int counter = 0;

	while (getchar() != EOF) {
		counter += 1;
	}

	printf("%d\n", counter);
	return 0;
}