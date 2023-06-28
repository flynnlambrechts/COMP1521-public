#include <stdio.h>

int main(int argc, char *argv[]) {
    FILE *f1 = fopen(argv[1], "r");
    FILE *f2 = fopen(argv[2], "r");
    int location = 0;
    int c1 = fgetc(f1);
    int c2 = fgetc(f2);
    while (c1 != EOF || c2 != EOF) {
        if (c1 == EOF) {
            printf("EOF on %s\n", argv[1]);
            fclose(f1);
            fclose(f2);
            return 0;
        } else if (c2 == EOF) {
            printf("EOF on %s\n", argv[2]);
            fclose(f1);
            fclose(f2);
            return 0;
        } else if (c1 != c2) {
            printf("Files differ at byte %d\n", location);
            fclose(f1);
            fclose(f2);
            return 0;
        }
        location++;
        c1 = fgetc(f1);
        c2 = fgetc(f2);
    }

    printf("Files are identical\n");
    fclose(f1);
    fclose(f2);
    return  0;
}