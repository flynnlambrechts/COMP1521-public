#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main(int argc, char *argv[]) {
    char *diaryName = ".diary";
    char *home = getenv("HOME");
    int length = strlen(home) + strlen(diaryName) + 2;
    char path[length];

    snprintf(path, length, "%s/%s", home, diaryName);
    
    FILE *d = fopen(path, "a");
    if (d == NULL) {
        perror(path);
        exit(1);
    }
    for (int arg = 1; arg < argc; arg++) {
        fputs(argv[arg], d);
        if (arg != argc - 1) {
            fputc(' ', d);
        }
    }
    fputc('\n', d);
    fclose(d);
    return 0;
}
