#include <stdio.h>
#include <stdint.h>

uint32_t six_middle_bits(uint32_t u) {
    
    // u is     0b 0100 0111 0110 1MMM MMM0 1110 0101 0110 in binary
    // u is     0b XXXX XXXX XXXX XMMM MMMX XXXX XXXX XXXX represented more arbitrarily
    // mask     0b 0000 0000 0000 0111 1110 0000 0000 0000
    // u & mask 0b 0000 0000 0000 0MMM MMM0 0000 0000 0000 
    //          0b 0000 0000 0000 0000 0000 0000 0MMM MMMM

    uint32_t result = 0;
    // uint32_t mask =  0b00000000000001111110000000000000;
    // uint32_t mask =  0x7E000;
    // uint32_t mask =  0b0011 1111 << 13;
    uint32_t mask =  0x3F << 13;
    // //  0b0100 0000 - 1 = 0 1111
    // uint32_t mask =  ((1 << 6) - 1) << 13;

    result = u & mask;     // 0b 0000 0000 0000 0MMM MMM0 0000 0000 0000 
    result = result >> 13; // 0b 0000 0000 0000 0000 0000 0000 0MMM MMMM 

    return result;
}


uint32_t six_middle_bits(uint32_t u) {
    // u is     0b 0100 0111 0110 1MMM MMM0 1110 0101 0110 in binary
    // u is     0b XXXX XXXX XXXX XMMM MMMX XXXX XXXX XXXX represented more arbitrarily
    // u >> 13  0b 0000 0000 0000 0XXX XXXX XXXX XXMM MMMM

    // mask             0b 0000 0000 0000 0000 0000 0000 0011 1111
    // (u >> 13) & mask 0b 0000 0000 0000 0000 0000 0000 0MMM MMMM
    //                

    uint32_t result = 0;
    uint32_t mask =  0x3F; // 0b0011 1111

    result = (u >> 13) & mask;  // 0b 0000 0000 0000 0000 0000 0000 0MMM MMMM 

    return result;
}



int main(void) {

    return 0;
}