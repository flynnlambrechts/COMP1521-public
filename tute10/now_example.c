// pid_t pid;
// char* args[] = {"/bin/date", "+%d-%m-%Y", NULL};
// int spawn_status = posix_spawn(&pid, args[0], NULL, NULL, args, environ);

// if (spawn_status != 0) {
// 	errno = spawn_status;
// 	perror("posix_spawn");
// 	exit(EXIT_FAILURE);
// }

// int spawn_exit_status;
// if (waitpid(pid, &spawn_exit_status, 0) == -1) {
// 	perror("waitpid");
// 	// Prints waitpid: The error described by errno's error code
// 	exit(EXIT_FAILURE);
// }