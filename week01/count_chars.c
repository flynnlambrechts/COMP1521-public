#include <stdio.h>

int main(void) {
    char character;
    int counter = 0;
    while ((character = getchar()) != EOF) {
        counter++;
    }
    return 0;
}