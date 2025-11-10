#include <stdio.h>

int main(int argc, char* argv[]) {
	if (argc != 2) {
		printf("Incorrect Number of arguments\n");
		printf("Usage: %s <name_of_file>\n", argv[0]);
	}
	FILE* file = fopen(argv[1], "a");
	if (file == NULL) {
		perror("");
	}

	char c;
	while ((c = getchar()) != EOF) {
		fputc(c, file);
		if (c == '\n') {
			break;
		}
	}
	return 0;
}