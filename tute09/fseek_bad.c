#include <stdio.h>

int main(void) {
    FILE *file = fopen("file1.txt", "r");

    fseek(file,  -100, SEEK_SET);

    char c = fgetc(file);
    putchar(c);
    putchar('\n');
    int pos = ftell(file);
    printf("%d\n", pos);

    return 0;
}