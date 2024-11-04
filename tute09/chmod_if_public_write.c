#include <stdio.h>
#include <stdlib.h>
#include <sys/stat.h>
#include <sys/types.h>
// #include <unistd.h>

// stat(char* pathname, struct stat* s)
// man 7 inode

void chmod_if_public_write(char *filename) {
  struct stat s;
  if (stat(filename, &s) == -1) {
    perror(filename);
    return;
  };

  mode_t mode = s.st_mode;
  if (!(mode & S_IWOTH)) {
    printf("%s is not publicly writable\n", filename);
    return;
  }

  printf("removing public write from %s\n", filename);
  mode_t new_mode = mode & ~S_IWOTH;
  if (chmod(filename, new_mode) != 0) {
    perror(filename);
    return;
  };
}

int main(int argc, char *argv[]) {
  for (int i = 1; i < argc; ++i) {
    chmod_if_public_write(argv[i]);
  }
}