#include <stdlib.h>
#include <stdio.h>

int main(int argc, char *argv[]) {
    if (argc <= 1) {
        fprintf(stderr, "%s", "Incorrect number of arguments\n");
        return 1;
    }

    FILE *f = fopen(argv[1], "w");

    if (f == NULL) {
        perror(argv[1]);
        return 1;
    }

    for (int i = 2; i < argc; i++) {
        fputc(atoi(argv[i]), f);
    }
    
    fclose(f);
    return 0;   
}