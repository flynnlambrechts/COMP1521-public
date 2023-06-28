#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>

int main(int argc, char *argv[]) {
    if (argc != 4) {
        fprintf(stderr, "%s", "Incorrect number of arguments\n");
        return 1;
    }

    FILE *f = fopen(argv[1], "w");

    if (f == NULL) {
        perror(argv[1]);
        return 1;
    }

    for (uint16_t i = atoi(argv[2]); i <= atoi(argv[3]); i++) {
        int maskShift = 1;
        uint16_t mask = (0xFF << (8));
        
        for (int j = 0; j < 2; j++) {
            uint8_t byte = (mask & i) >> (8 * maskShift);
            fputc(byte, f);
            maskShift--;
            mask >>= 8;

        }
    }
    fclose(f);
}