#include <pthread.h>
#include <stdbool.h>
#include <stdio.h>
#include <unistd.h>

void* thread_run(void* data) {
	while (true) {
		printf("feed me input!\n");
		sleep(1);
	}
	return NULL;
}

int main(void) {
	pthread_t thread;
	pthread_create(&thread, // the pthread_t handle that will represent this thread
	               NULL, // thread-attributes -- we usually just leave this NULL
	               thread_run, // the function that the thread should start executing
	               NULL // data we want to pass to the thread -- this will be
	                    // given in the `void *data` argument above
	);

	while (true) {
		char input[100];
		char* output = fgets(input, 100, stdin);
		if (output != NULL) {
			printf("You Entered: %s", output);
		}
	}

	void* retval;

	int status = pthread_join(thread, &retval);
	if (status != 0) {
		fprintf(stderr, "Something went wrong in my thread");
	}
	return 0;
}