#include <stdio.h>
#include <stdlib.h>
// #include <stdint.h>

// fscanf
// extend negs

int main(int argc, char *argv[]) {
  if (argc != 2) {
    fprintf("Needs command line arg", stderr);
    exit(1);
  }
  FILE *file = fopen(argv[1], "r");
  if (file == NULL) {
    perror(file);
    exit(EXIT_FAILURE);
  }
  int32_t number;
  //   fscanf
  while (fscanf("%x", &number) == 1) {
    int32_t low_byte = number & 0xFF;
    if (low_byte & (1 << 7)) {
      low_byte |= ~(0xFF);
    }

    printf("%d\n", low_byte);
  }
  fclose(file);
}