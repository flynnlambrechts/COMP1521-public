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

// u is 0100 0111 0110 1MMM MMM0 1110 0101 0110 in binary
// The MIDDLE BITS have been represented with M
// The rest of the bits are made up and arbitrary.
// The bit mask, 0x3F, is 0011 1111 (ie. last 6 bits are 1)

// Shifting u by 13 bits to the right gets it to the end, ie.
// u = 0000 0000 0000 0010 0011 1011 01MM MMMM

// When ANDed (&) together with the mask, we ONLY get the last
// 6 bits in u, which are the ORIGINAL (preshift) 6 middle bits.
// result = 0000 0000 0000 0000 0000 0000 00MM MMMM