#include "float_exp.h"

// given the 32 bits of a float return the exponent
uint32_t float_exp(uint32_t f) {
    uint32_t mask = 0xFF;
    mask <<= 23;
    uint32_t exp = mask & f;
    exp >>= 23;
    return exp; // REPLACE ME WITH YOUR CODE
}
