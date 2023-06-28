// Swap bytes of a short

#include <stdint.h>
#include <stdlib.h>
#include <assert.h>


// given uint16_t value return the value with its bytes swapped
uint16_t short_swap(uint16_t value) {
    uint16_t result = 0;
    uint16_t mask = 0xFF;
    result = mask & value;

    result <<= 8;
    mask <<= 8;

    result |= (mask & value) >> 8;
    return result;
}
