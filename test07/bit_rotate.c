#include "bit_rotate.h"

// return the value bits rotated left n_rotations
uint16_t bit_rotate(int n_rotations, uint16_t bits) {
    uint16_t result = bits;
    uint16_t mask = 0x8000;
    if (n_rotations > 0) {
        for (int i = 0; i < n_rotations; i++) {
            uint16_t temp = (mask & result) >> 15;
            result <<= 1;
            result |= temp;
        }
    } else {
        for (int i = 0; i > n_rotations; i--) {
            uint16_t temp = (1 & result);
            result >>= 1;
            result |= (temp << 15);
        }
    }
    

    return result; //REPLACE ME WITH YOUR CODE
}
