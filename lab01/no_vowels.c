#include <stdio.h>

int main(void) {
	char x;
	while (scanf("%c", &x) == 1) {
		if (x != 'a' && x != 'e' && x != 'i' && x != 'o' && x != 'u' && 
		    x != 'A' && x != 'E' && x != 'I' && x != 'O' && x != 'U') {
			printf("%c", x);
		}
	}
	return 0;
}
