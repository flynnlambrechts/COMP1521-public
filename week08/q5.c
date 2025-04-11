// Write a C program, first_line.c, which is given one command-line argument, 
// the name of a file, and which prints the first line of that file to stdout.
//  If given an incorrect number of arguments, or if there was an error opening 
// the file, it should print a suitable error message.

#include <stdio.h>
#include <stdlib.h>

int main(int argc, char *argv[]) {
    if (argc != 2) {
        fprintf(stderr, "Incorrect Number of command line arguments\n");
        exit(EXIT_FAILURE);
    }
    FILE *stream = fopen(argv[1], "r");
    if (stream == NULL) {
        perror(argv[0]);
        exit(EXIT_FAILURE);
    }

    char c;
    while ((c = fgetc(stream)) != EOF) {
        if (c == '\n') {
            break;
        }
        putchar(c);
    }
    putchar('\n');
    return 0;
}