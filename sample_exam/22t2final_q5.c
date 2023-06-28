// COMP1521 22T2 ... final exam, question 5

#include <stdio.h>

void print_bytes(FILE *file, long n) {
	fseek(file, 0, SEEK_END);
	int fileLength = ftell(file);
	// printf("%d\n", fileLength);
	fseek(file, 0, SEEK_SET);
	if (n > fileLength) {
		n = fileLength;
	} else if (n < -fileLength) {
		n = -fileLength;
	}

	int stop = n;
	if (n < 0) {
		stop = fileLength + n;
	}

	for (int i = 0; i < stop; i++) {
		fputc(fgetc(file), stdout);
	}

}
