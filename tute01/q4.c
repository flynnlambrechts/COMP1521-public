#include <stdio.h>

int main(void) {
	char str[10];
	str[0] = 'H';
	str[1] = 'i';
	str[2] = '\n';
	str[3] = '\0';
	printf("%s", str);
	return 0;
}