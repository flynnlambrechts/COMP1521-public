#include <stdint.h>

/**
 * Return the provided value but with its bytes reversed.
 *
 * For example, 22t2final_q3(0x12345678) => 0x78563412
 *
 * *Note* that your task is to
 * reverse the order of *bytes*,
 * *not* to reverse the order of bits.
 **/

uint32_t _22t2final_q3(uint32_t value) {
    uint32_t result = 0;
    uint32_t mask = 0xFF;
    for (int i = 0; i < (32 / 8); i++) {
        result <<= 8;
        result |= (mask & value);
        value >>= 8;
    }
    return result;
}
