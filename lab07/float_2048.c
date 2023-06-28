// Multiply a float by 2048 using bit operations only

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

int is_nan(float_components_t f) {
    return (f.exponent == 0xFF && f.fraction != 0);
}

// float_2048 is given the bits of a float f as a uint32_t
// it uses bit operations and + to calculate f * 2048
// and returns the bits of this value as a uint32_t
//
// if the result is too large to be represented as a float +inf or -inf is returned
//
// if f is +0, -0, +inf or -inf, or Nan it is returned unchanged
//
// float_2048 assumes f is not a denormal number
//
uint32_t float_2048(uint32_t f) {
    
    float_components_t flt = float_bits(f);
    // printf("0x%x\n", flt.fraction);
    if (is_nan(flt)) {
        // nan
    } else if (flt.exponent == 0 && flt.fraction == 0) {
        return 0 + (flt.sign << 31);
    } else if (flt.exponent >= 0xFF - 11) {

        flt.exponent = 0xFF;
        flt.fraction = 0;
        // if (flt.sign == 1) {
        //     return -inf;
        // }
        // return ;
    } else {
        flt.exponent += 11;
    } 

    uint32_t result = flt.sign << 31;
    result |= (flt.exponent << 23);
    result |= (flt.fraction);
    return result;
}
