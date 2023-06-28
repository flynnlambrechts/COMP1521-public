#include <stdio.h>
#include <stdlib.h>

#define SERIES_MAX 30

int fib(int x);

int main(void) {
    int n;
    while (scanf("%d", &n) == 1) {
        printf("%d\n", fib(n));
    }
    return EXIT_SUCCESS;
}

int fib(int x) {
    if (x == 0 || x == 1) {
        return x;
    } else {
        return fib(x - 1) + fib(x - 2);
    }
}