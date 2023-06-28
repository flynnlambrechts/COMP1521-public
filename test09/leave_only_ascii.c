#include <stdio.h>
#include <unistd.h>

int main(int argc, char *argv[]) {

    FILE *f = fopen(argv[1], "r+");
    // FILE *out = fopen(argv[1], "a");
    // fseek(out, 0, SEEK_SET);
    int c = fgetc(f);
    int writePos = 0;
    while (c != EOF) {
        int readPos = ftell(f);
        if (c < 128 || c > 255) {
            fseek(f, writePos, SEEK_SET);
            fputc(c, f);
            writePos = ftell(f);
        }
        fseek(f, readPos, SEEK_SET);
        c = fgetc(f);

    }
    
    fclose(f);
    // fclose(out);
    return 0;
}