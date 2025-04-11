#include <stdio.h>
#include <stdlib.h>


int main(int argc, char *argv[]) {
    FILE *file = fopen("File that doesnt exist.", "r");
    if (file == NULL) {
        perror(argv[0]);
    }
    return 0;

}