#include <sys/wait.h>
#include <spawn.h>
#include <stdio.h>

extern char** environ;

void spawn_and_wait(char** args) {
	// posix_spawn

	pid_t pid;
	int spawn_status = posix_spawn(&pid, args[0], NULL, NULL, args, environ);

	// spawn_status
	if (spawn_status != 0) {
		// ...
	}

	// waitpid
	if (waitpid(pid, NULL, 0) == -1) {
		perror("waitpid");
	}
}

int main(void) {
	// date +%d-%m-%Y
	char* date_args[] = {"/usr/bin/date", "+%d-%m-%Y", NULL};
	spawn_and_wait(date_args);

	// date +%T
	char* time_args[] = {"/usr/bin/date", "+%T", NULL};
	spawn_and_wait(time_args);

	// whoami
	char* whoami_args[] = {"/usr/bin/whoami", NULL};
	spawn_and_wait(whoami_args);

	// hostname -f
	char* hostname_args[] = {"/usr/bin/hostname", "-f", NULL};
	spawn_and_wait(hostname_args);

	// realpath .
	char* realpath_args[] = {"/usr/bin/realpath", ".", NULL};
	spawn_and_wait(realpath_args);
}