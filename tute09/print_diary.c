#include <stdio.h>
#include <stdlib.h>
#include <string.h>

// getenv
// snprintf

int main(void) {
  char *diary_name = ".diary";
  char *home_dir = getenv("HOME");
  if (home_dir == NULL) {
    home_dir = ".";
  }
  //   HOME/.diary
  int diary_pathname_len = strlen(home_dir) + strlen(diary_name) + 2;
  char *diary_path = malloc(sizeof(char) * diary_pathname_len);
  snprintf(diary_path, diary_pathname_len, "%s/%s", home_dir, diary_name);

  FILE *diary = fopen(diary_path, "r");
  if (diary == NULL) {
    perror(diary_path);
    exit(1);
  }

  char letter;
  while ((letter = fgetc(diary)) != EOF) {
    putchar(letter);
  }

  free(diary_path);
  fclose(diary);
}