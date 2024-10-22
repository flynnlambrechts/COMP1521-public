// Write a C function, six_middle_bits, which, given a uint32_t, extracts and returns the middle six bits
#include <stdio.h>
#include <stdint.h>

uint32_t extract_middle_6(uint32_t x) {
    uint32_t mask = (1 << 6) - 1;
    mask <<= 13;

    return (mask & x) >> 13;
}

// "100101010"
