#include <stdio.h>
#include <string.h>

#define SIZE 1000

int main(void) {
	char str[SIZE]; 
	while (fgets(str, SIZE, stdin) != NULL) {
		if (strlen(str) % 2 == 0) {
			fputs(str, stdout);
		}
		
	}
	return 0;
}
