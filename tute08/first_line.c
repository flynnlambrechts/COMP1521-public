#include <stdio.h>
#include <stdlib.h>

int main(int argc, char *argv[]) {
    if (argc != 2) {
        printf("Usage: <filename>\n");
    }

    FILE *file = fopen(argv[1], "r");
    if (file == NULL) {
        perror("fopen");
        exit(EXIT_FAILURE);
    }

    int c;
    while ((c = fgetc(file)) != EOF) {
        if (c == '\n') {
            break;
        }
        putchar(c);
    }
    putchar('\n');

    fclose(file);
    return 0;
}