#include <stdio.h>
#include <string.h>

#define MAX_LINE_LEN 10000

void my_grep(FILE* stream, char *test) {
    char buffer[MAX_LINE_LEN];
    int line_number = 0;
    while (fgets(buffer, MAX_LINE_LEN, stream) != NULL) {
        line_number++;
            char *substring = strstr(buffer, test);
            if (substring == NULL) {
                continue;
            }
            printf("%d: %s",line_number, buffer);
            if (buffer[strlen(buffer) - 1] != '\n') {
                putchar('\n');
            }
    }
    // putchar('\n');
}

int main(int argc, char *argv[]) {
    if (argc == 2) {
        my_grep(stdin, argv[2]);
    } else if (argc > 2) {
        for (int arg = 2; arg < argc; ++arg) {
            // printf("%s\n", argv[arg]);
            my_grep(fopen(argv[arg], "r"), argv[1]);
        }
    } else {
        fprintf(stderr, "oh no.\n");
        return 1;
    }
    return 0;

}