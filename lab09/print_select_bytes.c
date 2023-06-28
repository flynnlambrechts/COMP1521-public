#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>

int main(int argc, char *argv[]) {
    if (argc < 2) {
        fprintf(stderr, "Incorrect command line args\n");
    }
    FILE *f = fopen(argv[1], "r");
    if (f == NULL) {
        perror(argv[1]);
        exit(1);
    }

    for (int arg = 2; arg < argc; arg++) {
        int bit = atoi(argv[arg]);
        fseek(f, bit, SEEK_SET);
        int contents = fgetc(f);
        printf("%d - 0x%02X", contents, contents);
        if (isprint(contents)) {
            printf(" - '%c'", contents);
        }
        printf("\n");
    }

    fclose(f);
    return 0;
}