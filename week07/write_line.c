#include <stdio.h>
#include <stdlib.h>

int main(int argc, char *argv[]) {
    if (argc != 2) {
        fprintf(stderr, "Incorrect Number of command line arguments\n");
        exit(EXIT_FAILURE);
    }
    FILE *stream = fopen(argv[1], "w");
    if (stream == NULL) {
        perror(argv[0]);
        exit(EXIT_FAILURE);
    }
    char c;
    while ((c = getchar()) != EOF) {
        fputc(c, stream);
        if (c == '\n') {
            break;
        }
    }
    return 0;
}