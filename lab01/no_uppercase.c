#include <stdio.h>
#include <ctype.h>

int main(void) {
	int x = getchar();
	while (x != EOF) {
		if (isupper(x)) {
			x = tolower(x);
		}
		putchar(x);
		x = getchar();
	}
	return 0;
}
