#include <stdio.h>

int main(int argc, char *argv[]) {
  if (argc != 2) {
    fprintf(stderr, "Bad Input");
    return 1;
  }
  FILE *file = fopen(argv[1], "r");
  if (file == NULL) {
    perror(argv[1]);
    return 1;
  }
  //   read line
  char c;
  while ((c = fgetc(file)) != EOF) {
    if (c == '\n') {
      break;
    }
    putchar(c);
  }
  putchar('\n');
}