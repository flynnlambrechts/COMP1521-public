#include <sys/stat.h>
#include <stdio.h>

int main(int argc, char* argv[]) {
	if (argc <= 1) {
		fprintf(stderr, "Usage <filename...>");
	}
	for (int i = 1; i < argc; ++i) {
		struct stat stat_result;
		stat(argv[i], &stat_result);
		if (S_IWOTH & stat_result.st_mode) {
			mode_t new_mode = stat_result.st_mode & (~S_IWOTH);
			chmod(argv[i], new_mode);

			printf("removing public write from %s\n", argv[i]);
		}
		else {
			printf("%s is not publically writable\n", argv[i]);
		}
	}
}