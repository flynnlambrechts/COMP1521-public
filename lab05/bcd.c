#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include <assert.h>

int bcd(int bcd_value);

int main(int argc, char *argv[]) {

    for (int arg = 1; arg < argc; arg++) {
        long l = strtol(argv[arg], NULL, 0);
        assert(l >= 0 && l <= 0x0909);
        int bcd_value = l;

        printf("%d\n", bcd(bcd_value));
    }

    return 0;
}

// given a  BCD encoded value between 0 .. 99
// return corresponding integer
int bcd(int bcd_value) {

    // PUT YOUR CODE HERE
    int result = 0;
    // loop bytes
    int mask = 1;
    for (int i = 0; i < 2; i++) {
        // loop bits
        int digit = 0;
        
        for (int j = 0; j < 8; j++) {
            digit += bcd_value & mask;

            mask <<= 1;
        }
        
        int place = 1;
        if (i == 1) {
            place = 10;
        }
        digit >>= i * 8;
        result += digit * place;
    }
    return result;
}

