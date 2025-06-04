#include <stdio.h>

int sum(int n);

int main(int argc, char* argv[]) {
	int n;
	printf("Enter a number: ");
	scanf("%d", &n);

	int result = sum(n);
	printf("Sum of all numbers up to %d = %d\n", n, result);

	return 0;
}

int sum(int n) {
	if (n <= 0) {
		return 0;
	}
	else {
		return n + sum(n - 1);
	}
}