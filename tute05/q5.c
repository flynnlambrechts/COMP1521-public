#include <stdio.h>
#include <stdint.h>

#define READING   0x01 // 0b0000 0001
#define WRITING   0x02 // 0b0000 0010
#define AS_BYTES  0x04 // 0b0000 0100
#define AS_BLOCKS 0x08 // 0b0000 1000
#define LOCKED    0x10 // 0b0001 0000


int main(void) {
    uint8_t device = 0;
    // mark the device as locked for reading bytes
    // 0b0001 0101
    device = READING | LOCKED | AS_BYTES;

    // mark the device as locked for writing blocks
    // 0b0001 1010
    device = LOCKED | WRITING | AS_BLOCKS;
    
    // set the device as locked, leaving other flags unchanged
    // device = 0bdddd dddd;
                0b0001 0000;
    // device = 0bddd1 dddd;
    device = device | LOCKED;
    
    // remove the lock on a device, leaving other flags unchanged
     // device = 0bdddd dddd;
     // mask   = 0b1110 1111; and
     // device = 0bddd0 dddd;
    device = device & ~(LOCKED);

    // swap a device between reading and writing, leaving other flags unchanged
    // 
    return 0;
}