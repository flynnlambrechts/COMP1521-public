#include <stdio.h>
#include <stdlib.h>

#define MAX_PATH_LEN 1000

int main(void) {
    char* home_directory = getenv("HOME");
    char diary_path[MAX_PATH_LEN];
    snprintf(diary_path, MAX_PATH_LEN, "%s/.diary", home_directory);

    FILE* diary_file = fopen(diary_path, "r");
    int c;
    while ((c = fgetc(diary_file)) != EOF) {
        putchar(c);
    }

    fclose(diary_file);
    return 0;
}