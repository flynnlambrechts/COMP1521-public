#include <stdio.h>
#include <stdint.h>

uint32_t six_middle_bits(uint32_t input) {
    uint32_t mask = 0x3F; // 0b0011 1111
    mask <<= 13; // 0b00000000000001111110000000000000

    uint32_t result = input & mask;
    result >>= 13;
    return result;
}


int main(void) {
    uint32_t b = 0xAAAAAAAA;
    uint32_t res = six_middle_bits(b);

    printf("0x%x\n", res);
    return 0;
}