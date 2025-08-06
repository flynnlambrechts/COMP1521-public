// Tute Q5
#include <pthread.h>
#include <stdio.h>

// Useful Functions:
// pthread_create
// pthread_join

void* thread_function(void* arg) {
	while (1) {
		printf("Hello\n");
	}
	return NULL;
}

int main(void) {
	pthread_t thread;
	pthread_create(&thread, NULL, thread_function, NULL);

	while (1) {
		printf("there!\n");
	}

	return 0;
}