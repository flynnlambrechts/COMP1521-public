// COMP1521 22T2 ... final exam, question 9

#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>
#include <unistd.h>
#include <stdbool.h>
#include <string.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <stdatomic.h>
#include "22t2final_q9_helper.h"

long size = 0;

pthread_mutex_t size_lock = PTHREAD_MUTEX_INITIALIZER;


void *watch_file(void *arg) {
    char *filename = arg;
    int prev_filesize = 0;
    long filesize = file_size(filename);

    while (prev_filesize != FILE_NOT_FOUND) {
        pthread_mutex_lock(&size_lock);
        long prev_size = size;
        size -= prev_filesize;
        if (filesize != FILE_NOT_FOUND) {
            size += filesize;
        }
        long new_size = size;
        pthread_mutex_unlock(&size_lock);
        
        if (prev_size <= QUOTA && new_size > QUOTA) {
            printf("%s", QUOTA_EXCEEDED_MESSAGE);
        } else if (prev_size > QUOTA && new_size <= QUOTA) {
            printf("%s", QUOTA_RESOLVED_MESSAGE);
        }
        
        prev_filesize = filesize;
        filesize = file_size(filename);
    }
    free(filename);
    return NULL;
}

int main(void) {
    // printf("main called\n");
    pthread_t threads[MAX_WATCHED_FILES];
    int n_watched = 0;
    char filename[PATH_SIZE];
    while (fgets(filename, PATH_SIZE, stdin) != NULL) {
        filename[strlen(filename) - 1] = '\0';
        char *arg = strdup(filename);
        pthread_create(&threads[n_watched], NULL, watch_file, arg);
        n_watched++;
    }

    for (int i = 0; i < n_watched; i++) {
        pthread_join(threads[i], NULL);
    }

}
