// swap pairs of bits of a 64-bit value, using bitwise operators

#include <assert.h>
#include <stdint.h>
#include <stdlib.h>

// return value with pairs of bits swapped
uint64_t bit_swap(uint64_t value) {
    uint64_t mask1 = 1;
    uint64_t mask2 = 2;
    uint64_t result = 0;
    for (int i = 0; i < 32; i++) {
        uint64_t bit1 = value & mask1;
        uint64_t bit2 = value & mask2;
        bit1 <<= 1;
        bit2 >>= 1;
        result |= (bit1 | bit2);

        mask1 <<= 2;
        mask2 <<= 2;
    }

    return result;
}
