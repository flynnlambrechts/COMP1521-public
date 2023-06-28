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

atomic_long quota = 0;

void *watch_file(void *arg) {
    char *filename =arg;
    long prev_filesize = 0;
    long filesize = file_size(filename);
    while ((filesize = file_size(filename))!= FILE_NOT_FOUND) {
        long diff = filesize - prev_filesize;
        int old_quota = atomic_fetch_add(&quota, diff);
        if (old_quota <= QUOTA && old_quota + diff > QUOTA) {
            printf("%s", QUOTA_EXCEEDED_MESSAGE);
        } else if (old_quota > QUOTA && old_quota + diff <= QUOTA) {
            printf("%s", QUOTA_RESOLVED_MESSAGE);
        }
        prev_filesize = filesize;

    }

    int old_quota = atomic_fetch_add(&quota, -prev_filesize);

    if (old_quota <= QUOTA && old_quota -prev_filesize > QUOTA) {
        printf("%s", QUOTA_EXCEEDED_MESSAGE);
    } else if (old_quota > QUOTA && old_quota -prev_filesize <= QUOTA) {
        printf("%s", QUOTA_RESOLVED_MESSAGE);
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

