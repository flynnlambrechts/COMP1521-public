#include <stdio.h>
#include <ctype.h>

int main(int argc, char *argv[]) {
    int count = 0;
    FILE *f = fopen(argv[1], "r");
    int c = fgetc(f);
    while (c != EOF) {
        c = tolower(c);
        if (c == 'a' || c == 'e' || c == 'i' || c == 'o' || c == 'u') {
            count++;
        }
        c = fgetc(f);
    }
    printf("%d\n", count);
    fclose(f);
    return 0;
}