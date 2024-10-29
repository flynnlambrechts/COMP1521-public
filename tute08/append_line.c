#include <stdio.h>

int main(int argc, char *argv[]) {
  if (argc != 2) {
    fprintf(stderr, "Bad Input");
    return 1;
  }
  FILE *file = fopen(argv[1], "a");
  if (file == NULL) {
    perror(argv[1]);
    return 1;
  }
  //   read line
  char c;
  while ((c = fgetc(stdin)) != EOF) {
    if (c == '\n') {
      break;
    }
    fputc(c, file);
  }
  fputc('\n', file);
}