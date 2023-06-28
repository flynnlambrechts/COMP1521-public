#include <stdio.h>
#include <stdlib.h>

int main(int argc, char *argv[]) {
    int i = 2;
    int min = atoi(argv[1]);
    int max = atoi(argv[1]);
    int sum = atoi(argv[1]);
    int prod = atoi(argv[1]);
    
    while (i < argc) {
        int x = atoi(argv[i]);
        if (x < min) {
            min = x;
        }
        if (x > max) {
            max = x;
        }
        sum += x;
        prod *= x;

        i++;
    }
    printf("MIN:  %d\nMAX:  %d\nSUM:  %d\nPROD: %d\nMEAN: %d\n",
           min, max, sum, prod, sum/(argc - 1));
    return 0;
}
