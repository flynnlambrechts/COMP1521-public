#include <stdio.h>
#include <spawn.h>
#include <pthread.h>
#include <stdatomic.h>
#include <sys/wait.h>
#include <unistd.h>
#include <stdlib.h>

atomic_int bankA = 0;
int bankB = 0;

pthread_mutex_t bankB_lock;

void *addBankA(void *arg) {
    int *amount = arg;
    for (int i = 0; i < *amount; i++) {
        sleep(1);
        bankA++;
    }
    printf("A Finished when amount is %d\n", *amount);
    return NULL;
}


void *addBankB(void *arg) {
    int *amount = arg;
    for (int i = 0; i < *amount; i++) {
        sleep(1);
        pthread_mutex_lock(&bankB_lock);
        bankB++;
        pthread_mutex_unlock(&bankB_lock);
    }
    printf("B Finished when amount is %d\n", *amount);
    return NULL;
}



int main(int argc, char *argv[]) {
    pthread_t threadsA[3];
    pthread_t threadsB[3];

    int argsA[3];
    int argsB[3];
    for (int i = 0; i < 3; i++) {
        argsA[i] = i * 10;
        argsB[i] = i * 10;
        pthread_create(&threadsA[i], NULL, addBankA, &argsA[i]);
        pthread_create(&threadsB[i], NULL, addBankB, &argsB[i]);
    }
    if (argc >= 1) {
        int pargc = 0;
        char *pargv[argc];
        for (int arg = 1; arg < argc; arg++) {
            pargv[pargc] = argv[arg];
            pargc++;
        }
        pargv[pargc] = NULL;
        
        pid_t pid; 
        extern char **environ;
        
        if (posix_spawn(&pid, pargv[0], NULL, NULL, pargv, environ)!= 0) {
            perror(pargv[0]);
            exit(1);
        }

        int exit_status;
        waitpid(pid, &exit_status, 0);
    }

    for (int i = 0; i < 3; i++) {
        // int exit_status;
        pthread_join(threadsA[i], NULL);
        pthread_join(threadsB[i], NULL);
    }
    printf("BankA: %d BankB: %d\n", bankA, bankB);
    return 0;
}