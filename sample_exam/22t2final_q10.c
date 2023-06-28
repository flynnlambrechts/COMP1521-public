// COMP1521 22T2 ... final exam, question 10

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>
#include <assert.h>
#include <spawn.h>
#include <fcntl.h>
#include <glob.h>
#include <dirent.h>

#include <unistd.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <sys/wait.h>

#define MAX_LINE_LENGTH     1024     // Useful for input string.
#define MAX_DIR_LENGTH      1024     // Useful for the current working directory.
#define MAX_COMMAND_LENGTH  128      // Useful for the command to pass to `posix_spawn`.
#define MAX_ARGUMENTS       32       // Useful for the arguments to pass to `posix_spawn`.
#define MAX_ARG_LENGTH      128      // Useful for the arguments to pass to `posix_spawn`.
#define DIRECTORY_SEPARATOR '/'      // Useful to tell if a command is absolute or not.
#define PATH_TOKENIZER      ":"      // Useful to tokenize the PATH environment variable.

bool is_executable(const char *pathname);
glob_t do_glob(char *text);

int main(void) {
    // Don't buffer stdout.
    setbuf(stdout, NULL);

    // Pass this to `posix_spawn` for the environment.
    extern char **environ;
    (void) environ; // Suppress unused warning; feel free to remove

    char cwd[MAX_DIR_LENGTH];
    getcwd(cwd, sizeof cwd);

    char line[MAX_LINE_LENGTH];

    char *envpath = getenv("PATH");
    while (true) {
        printf("[rush] ");

        // Get input from user or exit
        if (!fgets(line, sizeof line, stdin)) {
            break;
        }

        // Remove trailing newline
        char *newline = strrchr(line, '\n');
        if (newline) *newline = '\0';


        char *args[MAX_ARGUMENTS];
        char *token = strtok(line, " ");
        int ntokens = 0;
        while (token != NULL) {
            args[ntokens] = token;
            ntokens++;
            token = strtok(NULL, " ");
        }
        if (ntokens == 0) {
            continue;
        }

        int nglobbed_args = 1;
        char *globbed_args[MAX_ARGUMENTS];
        globbed_args[0] = args[0];
        int arg = 1;
        for (; arg < ntokens; arg++) {
            glob_t glob = do_glob(args[arg]);
            // int j = arg;
            for (int j = 0; j < glob.gl_pathc; j++) {
                globbed_args[nglobbed_args] = glob.gl_pathv[j];
                nglobbed_args++;
            }
            // arg = j;
            // posix_args[i] = args[i];
        }
        ntokens = nglobbed_args;

        // for (int i = 0; i < nglobbed_args; i++) {
        //     printf("%s\n", globbed_args[i]);
        // }

        if (strcmp(globbed_args[0], "exit") == 0) {
            break;
        } else if (strcmp(globbed_args[0], "cd") == 0) {
            char *directory;
            if (ntokens == 1) {
                directory = getenv("HOME");
            } else {
                // printf("%s args[1]\n", args[1]);
                directory = globbed_args[1];
                // printf("%s globbed args[1]\n", globbed_args[1]);
            }
            // printf("%s directory\n", directory);
            if (chdir(directory) == -1) {
                fprintf(stderr, "cannot cd to %s\n", directory);
            } else {
                getcwd(cwd, sizeof cwd);
            }
            // printf("cded into %s\n", cwd);
        } else if (strcmp(globbed_args[0], "pwd") == 0) {
            printf("%s\n", cwd);
        } else {
            char command[MAX_COMMAND_LENGTH * 2 + 1];
            strcpy(command, globbed_args[0]);
            if (strchr(globbed_args[0], DIRECTORY_SEPARATOR) == NULL) {
              
                // command = NULL;

                char *searchpath = strdup(envpath);

                char *path = strtok(searchpath, PATH_TOKENIZER);
                // char *paths[100];
                // int npaths = 0;
                // char executable[MAX_ARG_LENGTH] = "\0";
                while (path != NULL) {

                    // printf("%s\n", path);
                    DIR *dirp = opendir(path);
                    struct dirent *direc;
                    while ((direc = readdir(dirp)) != NULL) {
                        if (strcmp(globbed_args[0], direc->d_name) == 0) {
                            // printf("%s\n", direc->d_name);
                            snprintf(command, sizeof command, "%s/%s", path, direc->d_name);
                        }
                    }
                    path = strtok(NULL, PATH_TOKENIZER);
                }
                free(searchpath);
                // command = executable;
            } 
            // char *command = globbed_args[0]
            if (!is_executable(command)) {
                fprintf(stderr, "%s: cannot execute command\n", command);
                continue;
            }
            pid_t pid;

            char *posix_args[MAX_ARGUMENTS + 1];

            posix_args[0] = command;
            // int posix_argc = 1;
            // int i = 1;
            for (int i = 1; i < ntokens; i++) {
                posix_args[i] = globbed_args[i];
            }
            // posix_args[posix_argc] = NULL;
            posix_args[ntokens] = NULL;
            posix_spawn(&pid, command, NULL, NULL, posix_args, environ);

            int exit_status;
            waitpid(pid, &exit_status, 0);
        }
    }
}

//
// Check whether this process can execute a certain file.
// Useful for checking whether a command is in the PATH.
//
bool is_executable(const char *pathname) {
    struct stat s;
    return
        // does the file exist?
        stat(pathname, &s) == 0 &&
        // is the file a regular file?
        S_ISREG(s.st_mode) &&
        // can we execute it?
        faccessat(AT_FDCWD, pathname, X_OK, AT_EACCESS) == 0;
}

//
// Glob some given text with the required options for the shell.
// Useful for globbing arguments in feature 5.
//
glob_t do_glob(char *text) {
    glob_t results = {};
    assert(glob(text, GLOB_NOCHECK | GLOB_TILDE, NULL, &results) == 0);

    return results;
}
