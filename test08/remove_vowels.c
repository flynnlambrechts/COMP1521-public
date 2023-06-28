#include <stdio.h>
#include <ctype.h>

int main(int argc, char *argv[]) {
    FILE *read = fopen(argv[1], "r");
    FILE *write = fopen(argv[2], "w");

    int c = fgetc(read);
    while (c != EOF) {
        int cLower = tolower(c);
        
        if (cLower == 'a' || cLower == 'e' || cLower == 'i' || cLower == 'o' || cLower == 'u') {
            c = fgetc(read);
            continue;
        }
        fputc(c, write);
        c = fgetc(read);
    }

    fclose(read);
    fclose(write);
    return 0;
}