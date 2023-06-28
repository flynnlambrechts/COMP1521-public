// generate the encoded binary for an addi instruction, including opcode and operands

#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include <assert.h>

#include "addi.h"

// return the encoded binary MIPS for addi $t,$s, i
uint32_t addi(int t, int s, int i) {
    // 0010 00ss ssst tttt IIII IIII IIII IIII
    uint32_t result = 0;
    result += 8;
    result <<= 5;
    int mask = 0x1F;
    result += s & mask; 
    result <<= 5;
    result += t & mask;
    result <<= 4 * 4;
    mask = 0xFFFF;
    result += i & mask;
    return result; 

}
