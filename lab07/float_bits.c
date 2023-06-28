// Extract the 3 parts of a float using bit operations only

#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include <assert.h>

#include "floats.h"

// separate out the 3 components of a float
float_components_t float_bits(uint32_t f) {
    float_components_t result;
    // 0b100 0000 0000 0000 0000 0000 0000 0000
    unsigned int mask = 1u << (31);
    // int mask = 0x40000000;
    result.sign = (mask & f) >> 31;
    
    mask = 0xFF << 23;
    result.exponent = (mask & f) >> 23;
    // 0b011 1111 1111 1111 1111 1111
    mask = 0x7FFFFF;
    result.fraction = (mask & f);
    
    return result;
}

// given the 3 components of a float
// return 1 if it is NaN, 0 otherwise
int is_nan(float_components_t f) {
    return (f.exponent == 0xFF && f.fraction != 0);
}

// given the 3 components of a float
// return 1 if it is inf, 0 otherwise
int is_positive_infinity(float_components_t f) {
    return (f.sign == 0 && f.exponent == 0xFF && f.fraction == 0);
}

// given the 3 components of a float
// return 1 if it is -inf, 0 otherwise
int is_negative_infinity(float_components_t f) {
    return (f.sign == 1 && f.exponent == 0xFF && f.fraction == 0);
}

// given the 3 components of a float
// return 1 if it is 0 or -0, 0 otherwise
int is_zero(float_components_t f) {


    return (f.exponent == 0 && f.fraction == 0);
}
