#include <stdlib.h>
#include <pthread.h>

void *increment_and_sleep(void *arg);

void costly_addition(int num)
{
    pthread_t ids[num];

    // pthread_t thread_id;
    int arg = num;
    for (int i = 0; i < num; i++) {
        pthread_create(&ids[i], NULL, increment_and_sleep, &arg);
    }
    for (int i = 0; i < num; i++) {
        pthread_join(ids[i], NULL);
    }
}
