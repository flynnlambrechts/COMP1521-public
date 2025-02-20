#include <stdio.h>

int sum(int n);

int main(void) {
        int n;
        printf("Enter a number: ");
        scanf("%d", &n);

        int result = sum(n);
        printf("Sum of all numbers up to %d = %d\n", n, result);

        return 0;
}

// int sum(int n) {
//     int result = 0;
//     for (int i = 0; i <= n; i++) {
//         result += i;
//     }
//     return result;
// }


int sum(int n) {
    if (n < 0) {
        printf("Bad input\n");
        return -1;
    }
    if (n == 0) {
        return 0;
    }
    return n + sum(n - 1);
    
}