// man 3 getchar
#include <stdio.h>

int main() {
	int count = 0;
	while (getchar() != EOF) {
		count = count + 1;
	}
	printf("%d\n", count);
	return 0;
}