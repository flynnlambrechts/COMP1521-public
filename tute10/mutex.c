#include <pthread.h>
#include <stdio.h>

// Useful Functions:

// pthread_mutex_lock
// pthread_mutex_unlock

pthread_mutex_t global_total_mutex = PTHREAD_MUTEX_INITIALIZER;
int global_total = 0;

void* add_5000_to_counter(void* data) {
	for (int i = 0; i < 5000; i++) {
		// increment the global total by 1
		pthread_mutex_lock(&global_total_mutex);
		global_total++;
		pthread_mutex_unlock(&global_total_mutex);
	}

	return NULL;
}

int main(void) {
	pthread_t thread1;
	pthread_create(&thread1, NULL, add_5000_to_counter, NULL);

	pthread_t thread2;
	pthread_create(&thread2, NULL, add_5000_to_counter, NULL);

	pthread_t thread3;
	pthread_create(&thread3, NULL, add_5000_to_counter, NULL);

	pthread_join(thread1, NULL);
	pthread_join(thread2, NULL);
	pthread_join(thread3, NULL);
	// if program works correctly, should print 10000
	printf("Final total: %d\n", global_total);
}