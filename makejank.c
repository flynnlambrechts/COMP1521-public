#include <spawn.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAX_LINE_LEN 64
#define MAX_ARGS

int main() {
    FILE *makefile = fopen("jankmakefile", "r");
    char targetLine[MAX_LINE_LEN];
    fgets(targetLine, sizeof targetLine, makefile);
    char *target = strtok(targetLine, ": ");
    printf("'%s'\n", target);
    char *dependency;
    while ((dependency = strtok(NULL, " ")) != NULL) {
        printf("%s ", dependency);
    }
    printf("\n");

}