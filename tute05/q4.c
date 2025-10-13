#include <stdint.h>

uint32_t six_middle_bits() {
	// u = 0100 0111 0110 1MMM MMM0 1110 0101 0110
	// we need
	// result = 0000 0000 0000 0000 0000 0000 0000 00MM MMMM

	// Two ways
	// Mask then shift
	// Shift then mask

	// How to create a mask
	// 1. Binary
	// mask = 0b111111;
	// 2. Hexadecimal
	// mask = 0x3F;
	// 3. My Way
	// mask = (1 << 6) - 1

	return 0;
}

int main(void) {
	print("%x\n", six_middle_bits());
}
