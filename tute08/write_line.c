#include <stdio.h>
#include <stdlib.h>

int main(int argc, char *argv[]) {
    if (argc != 2) {
        printf("Usage: <filename>\n");
    }

    FILE *file = fopen(argv[1], "w");
    if (file == NULL) {
        perror("fopen");
        exit(EXIT_FAILURE);
    }

    int c;
    while ((c = getchar()) != EOF) {
        if (c == '\n') {
            break;
        }
        fputc(c, file);
    }
    fputc('\n', file);

    fclose(file);
    return 0;
}