#include <stdbool.h>
#include <string.h>
#include <stdlib.h>
#include <stdint.h>
#include <stdio.h>


// Given an UTF-8 string, return the index of the first invalid byte.
// If there are no invalid bytes, return -1.

// Do NOT change this function's return type or signature.
int invalid_utf8_byte(char *utf8_string) {
    
    int i = 0;
    while (true) {
        uint8_t byte = utf8_string[i];

        if (byte == '\0') {
            break;
        }
        if (!(byte & (1 << 7))) {
            i++;
            continue;
        }
        
        int n_bytes = 1;

        uint8_t mask = 0x3 << 6;
        
        for (int j = 0; j < 4; j++) {
            // printf("mask 0x%x\n", mask);
            if ((byte & mask) == mask) {
                n_bytes++;
            } else {
                break;
            }
            mask = (mask >> 1) | (1 << 7);
        }


        if (n_bytes > 4 || n_bytes == 1) {
            return i;
        }

        for (int j = 1; j < n_bytes; j++) {
            i++;
            byte = utf8_string[i];
            if (!(byte & (1 << 7)) || (byte & (1 << 6))) {
                return i;
            }
        }
        i++;
    }

    return -1;
}
