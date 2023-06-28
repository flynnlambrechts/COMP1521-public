// COMP1521 22T2 ... final exam, question 1

#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>

int count_zero_bits(uint32_t x) {
	int count = 0;
	for (int i = 0; i < 32; i++) {
		if (!(x & (uint32_t)1)) {
			count++;
		}
		x >>= 1;
	}
	return count;
}
