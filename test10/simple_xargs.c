#include <stdio.h>
#include <spawn.h>
#include <sys/wait.h>

int main(int argc, char *argv[]) {
    char *path = argv[1];
    char arg[1024];
    while (scanf("%s", arg) != EOF) {
        pid_t pid;
        extern char **environ;
        char *args[] = {path, arg, NULL};
        posix_spawn(&pid, path, NULL, NULL, args, environ);

        int exit_status;
        waitpid(pid, &exit_status, 0);
    }
}