#include <stdio.h>
#include <stdlib.h>

int* get_num_ptr(void);

int main(void) {
	int* num_ptr = get_num_ptr();
	printf("%d\n", *num_ptr);
	free(num_ptr);
}

int* get_num_ptr(void) {
	int* x_ptr = malloc(sizeof(int));
	*x_ptr = 42;
	return x_ptr;
}