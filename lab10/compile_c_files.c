// compile .c files specified as command line arguments
//
// if my_program.c and other_program.c is speicified as an argument then the follow two command will be executed:
// /usr/local/bin/dcc my_program.c -o my_program
// /usr/local/bin/dcc other_program.c -o other_program

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <spawn.h>
#include <sys/types.h>
#include <sys/wait.h>

#define DCC_PATH "/usr/local/bin/dcc"

int main(int argc, char **argv) {
    for (int arg = 1; arg < argc; arg++) {
        extern char **environ;
        pid_t pid;

        int nameLen = strlen(argv[arg]);

        char outputName[nameLen + 1];
        strcpy(outputName, argv[arg]);
        outputName[nameLen - 2] = '\0';
        // printf("%s -o %s\n", argv[arg], outputName);

        printf("running the command: \"%s %s -o %s\"\n", DCC_PATH, argv[arg], outputName);

        char *dcc_args[] = {DCC_PATH, argv[arg], "-o", outputName, NULL};
        if (posix_spawn(&pid, DCC_PATH, NULL, NULL, dcc_args, environ) != 0) {
            perror("spawn");
            exit(1);
        }
        
        int exit_status;
        if (waitpid(pid, &exit_status, 0) == -1) {
            perror("waitpid");
            exit(1);
        }
        // printf("dcc exit status was %d\n", exit_status);
    }    
    return EXIT_SUCCESS;
}
