#include <pthread.h>
#include <stdio.h>

int global_total = 0;

void* add_5000_to_counter(void* data) {
	for (int i = 0; i < 500000; i++) {
		// sleep for 1 nanosecond
		// nanosleep(&(struct timespec){.tv_nsec = 1}, NULL);

		// increment the global total by 1
		global_total++;
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

	pthread_t thread4;
	pthread_create(&thread4, NULL, add_5000_to_counter, NULL);

	pthread_t thread5;
	pthread_create(&thread5, NULL, add_5000_to_counter, NULL);

	pthread_t thread6;
	pthread_create(&thread6, NULL, add_5000_to_counter, NULL);

	pthread_join(thread1, NULL);
	pthread_join(thread2, NULL);
	pthread_join(thread3, NULL);
	pthread_join(thread4, NULL);
	pthread_join(thread5, NULL);
	pthread_join(thread6, NULL);

	// if program works correctly, should print 10000
	printf("Final total: %d\n", global_total);
}