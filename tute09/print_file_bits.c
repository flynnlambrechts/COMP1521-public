#include <stdio.h>
#include <stdint.h>

int main(int argc, char* argv[]) {
    FILE *file_create = fopen(argv[1], "w");

    fputc(0x5, file_create);
    fputc(0x6, file_create);
    fputc(0x7, file_create);
    fputc(0xff, file_create);
    fclose(file_create);

    FILE *file = fopen(argv[1], "r");

    // uint32_t number = 0;
    fseek(file, 3, SEEK_CUR);
    uint8_t byte4 = fgetc(file);

    printf("%d\n", byte4);
    return 0;
}