#include <sys/wait.h>
#include <errno.h>
#include <spawn.h>
#include <stdio.h>
#include <stdlib.h>

extern char** environ;

void run_and_wait(char* argv[]) {
	pid_t pid;
	// call spawn and check error status
	int spawn_status = posix_spawn(&pid, argv[0], NULL, NULL, argv, environ);

	if (spawn_status != 0) {
		// Usually, most library functions will set errno when they fail.
		// However, posix_spawn() returns its error code and doesn't set errno,
		// so we need to do this ourselves.
		errno = spawn_status;
		perror("posix_spawn");
		exit(EXIT_FAILURE);
	}

	int exit_status;
	// wait for process to finish (waitpid)

	if (waitpid(pid, &exit_status, 0) == -1) {
		perror("waitpid");
		exit(EXIT_FAILURE);
	}

	// check exit status
	if (exit_status != 0) {
		errno = exit_status;
		perror(argv[0]);
		exit(EXIT_FAILURE);
	}
	// ALTERNATIVE:
	// If we wanted to print out the exit status of the process, we could
	// with the following code:
	// printf("Exited with status %d\n", WEXITSTATUS(spawn_exit_status));
}

int main(void) {
	// date +%d-%m-%Y
	// date +%T
	// whoami
	// hostname -f
	// realpath .

	// arguments argument
	// Note: NULL terminated, must include name of process like argv
	char* argv[] = {"/usr/bin/date", "+%d-%m-%Y", NULL};
	run_and_wait(argv);
	char* argv2[] = {"/usr/bin/date", "+%T", NULL};
	run_and_wait(argv2);
	return 0;
}