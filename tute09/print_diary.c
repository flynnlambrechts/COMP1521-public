#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main(void) {
    char *home_directory = getenv("HOME");
    // printf("%s\n", home_directory);
    char *diary_name = ".diary";
    int length = strlen(home_directory) + strlen(diary_name) + 2;

    char diary_path[length];

    snprintf(diary_path, length, "%s/%s", home_directory, diary_name);
    // printf("%s\n", diary_path);
    FILE *diary = fopen(diary_path, "r");
    
    if (diary == NULL) {
        perror("fopen");
        exit(EXIT_FAILURE);
    }

    int c;
    while ((c = fgetc(diary)) != EOF) {
        putchar(c);
    }
    return 0;
}