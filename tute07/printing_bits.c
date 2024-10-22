#include <stdio.h>
#include <stdint.h>
#include <math.h>

void print_bits(int8_t number) {
	printf("0b");
	for (uint8_t past = ~((uint8_t)-1 >> 1); past; past >>= 1) {
		printf("%d", (past & number) > 0);
	}
	putchar('\n');
    return;
}

int main(void) {
    // for (int8_t i = -128; i <= 126; ++i) {
    //     printf("%5d : ", i);
    //     print_bits(i);
    // }
    float x = INFINITY;
    if (x < x / 2) {
        printf("problem");
    } else {
        printf("good");
    }
    putchar('\n');
    printf("%f", x / x);
    putchar('\n');
    return 0;
}