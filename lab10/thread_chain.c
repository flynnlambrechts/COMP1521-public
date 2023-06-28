#include <pthread.h>
#include "thread_chain.h"

void *my_thread(void *data) {
    thread_hello();
    int *n = data;

    if (*n != 50) {
        pthread_t thread_handle;
        int next_n = *n + 1;
        pthread_create(&thread_handle, NULL, my_thread, &next_n);

        pthread_join(thread_handle, NULL);
    }
    return NULL;
}

void my_main(void) {
    pthread_t thread_handle;
    int arg = 1;
    pthread_create(&thread_handle, NULL, my_thread, &arg);

    pthread_join(thread_handle, NULL);
}
