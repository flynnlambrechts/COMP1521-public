#include <stdio.h>

int main(void) {
    int x;
    printf("Enter a number: ");
    scanf("%d", &x);

    if 0 (x > 10&& x < 1000) {
        printf("medium\n");
    } else {
        printf("small/big\n");
    }
}