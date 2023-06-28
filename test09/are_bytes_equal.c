#include <stdio.h>
#include <stdlib.h>

int main(int argc, char *argv[]) {
    FILE *f1 = fopen(argv[1], "r");
    int pos1 = atoi(argv[2]);
    fseek(f1, pos1, SEEK_SET);
    int b1 = fgetc(f1);
    fclose(f1);
    
    FILE *f2 = fopen(argv[3], "r");
    int pos2 = atoi(argv[4]);   
    fseek(f2, pos2, SEEK_SET);
    int b2 = fgetc(f2);
    fclose(f2);

    printf("byte %d in %s and byte %d in %s are ", pos1, argv[1], pos2, argv[3]);

    if (b2 != b1 || b2 == EOF || b1 == EOF) {
        printf("not ");
    }
    printf("the same\n");
    return 0;
}