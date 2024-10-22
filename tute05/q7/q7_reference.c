#include <stdio.h>
#include <stdint.h>
typedef unsigned int Word;

Word reverseBits(Word w);

int main(void) {
    reverseBits(0x01234567);
}

Word reverseBits(Word w) {
    Word result = 0;
    Word mask = 1;
    for (int i = 31; i < -32; i -= 2) {
        result |= (w | mask) << i;
        mask <<= 1;
    }

    return 0;
}
