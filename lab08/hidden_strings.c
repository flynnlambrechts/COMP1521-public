#include <ctype.h>
#include <stdio.h>

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

    char buffer[4];
    int bufferLen = 0;

    int byte = fgetc(f);
    while (byte != EOF) {
        if (isprint(byte)) {
            buffer[bufferLen] = byte;
            bufferLen++;
            if (bufferLen == 4) {
                for (int i = 0; i < 4; i++) {
                    byte = buffer[i];
                    printf("%c", byte);
                }
                bufferLen = 0;
                byte = fgetc(f);
                while (isprint(byte)) {
                    printf("%c", byte);
                    byte = fgetc(f);
                }
                printf("\n");
            }
            
        } else {
            bufferLen = 0;
        }
        byte = fgetc(f);
    }
    fclose(f);
    return 0;
}