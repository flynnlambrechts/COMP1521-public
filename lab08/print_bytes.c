#include <stdio.h>
#include <ctype.h>
#include <stdlib.h>

int main(int argc, char *argv[]) {
    if (argc <= 1) {
        fprintf(stderr, "%s", "Incorrect number of arguments\n");
        return 1;
    }

    FILE *f = fopen(argv[1], "r");

    if (f == NULL) {
        perror(argv[1]);
        return 1;
    }

    int byte = fgetc(f);
    
    long i = 0;
    while (byte != EOF) {
        printf("byte %4ld: %3d 0x%02x", i, byte, byte);
        
        if (isprint(byte)) {
            printf(" '%c'", byte);
        }
        printf("\n");
        byte = fgetc(f);
        i += 1;
    } 


    return 0;
}