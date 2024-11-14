#include <spawn.h>
#include <stdio.h>
#include <stdlib.h>
// #include <sys/wait.h>

extern char **environ;

// date +%d-%m-%Y
// date +%T
// whoami
// hostname -f
// realpath .

void spawn_process(char **args) {
  pid_t pid;
  int spawn_result = posix_spawn(&pid, args[0], NULL, NULL, args, environ);
  if (spawn_result != 0) {
    perror(args[0]);
    exit(EXIT_FAILURE);
  }
  int wait_result;
  if (waitpid(pid, &wait_result, 0) == -1) {
    perror("waitpid");
    exit(EXIT_FAILURE);
  };
}

int main(int argc, char *argv[]) {
  char *date_args[] = {"/bin/date", "+%d-%m-%Y", NULL};
  spawn_process(date_args);
  char *date_args2[] = {"/bin/date", "+%T", NULL};
  spawn_process(date_args2);
  char *whoami_args[] = {"/usr/bin/whoami", NULL};
  spawn_process(whoami_args);
  char *hostname_args[] = {"/bin/hostname", "-f", NULL};
  spawn_process(hostname_args);
  char *realpath_args[] = {"/bin/realpath", ".", NULL};
  spawn_process(realpath_args);

  return 0;
}