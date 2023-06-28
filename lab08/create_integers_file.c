#include <stdio.h>
#include <stdlib.h>


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

    for (int i = atoi(argv[2]); i <= atoi(argv[3]); i++) {
        fprintf(f, "%d\n", i);
    }
    fclose(f);
    return 0;
}