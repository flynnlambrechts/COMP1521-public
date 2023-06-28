#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include <assert.h>

#define N_BCD_DIGITS 8

uint32_t packed_bcd(uint32_t packed_bcd);

int main(int argc, char *argv[]) {

    for (int arg = 1; arg < argc; arg++) {
        long l = strtol(argv[arg], NULL, 0);
        assert(l >= 0 && l <= UINT32_MAX);
        uint32_t packed_bcd_value = l;

        printf("%lu\n", (unsigned long)packed_bcd(packed_bcd_value));
    }

    return 0;
}

// given a packed BCD encoded value between 0 .. 99999999
// return the corresponding integer
uint32_t packed_bcd(uint32_t packed_bcd_value) {
    uint32_t result = 0;
    uint32_t mask = 0xF;

    int place = 1;

    for (int i = 0; i < N_BCD_DIGITS; i++) {
        
        int digit = packed_bcd_value & mask;
        digit >>= (i) * 4;
        digit &= 0xF;
        // printf("mask: 0x%x, digit: 0x%x\n", mask, digit);
        
        result += place * digit;
        
        mask <<= 4;
        place *= 10;
    }

    return result;
}
