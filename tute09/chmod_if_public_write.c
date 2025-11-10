// dcc chmod_if_public_write.c -o chmod_if_public_write
// ls -ld file_modes.c file_modes file_sizes.c file_sizes
// -rwxr-xrwx 1 z5555555 z5555555 116744 Nov  2 13:00 file_sizes
// -rw-r--r-- 1 z5555555 z5555555    604 Nov  2 12:58 file_sizes.c
// -rwxr-xr-x 1 z5555555 z5555555 222672 Nov  2 13:00 file_modes
// -rw-r--rw- 1 z5555555 z5555555   2934 Nov  2 12:59 file_modes.c
// ./file_modes file_modes file_modes.c file_sizes file_sizes.c
// removing public write from file_sizes
// file_sizes.c is not publically writable
// file_modes is not publically writable
// removing public write from file_modes.c
// ls -ld file_modes.c file_modes file_sizes.c file_sizes
// -rwxr-xr-x 1 z5555555 z5555555 116744 Nov  2 13:00 file_sizes
// -rw-r--r-- 1 z5555555 z5555555    604 Nov  2 12:58 file_sizes.c
// -rwxr-xr-x 1 z5555555 z5555555 222672 Nov  2 13:00 file_modes
// -rw-r--r-- 1 z5555555 z5555555   2934 Nov  2 12:59 file_modes.c
#include <stdio.h>
#include <stdlib.h>
#include <sys/stat.h>

void chmod_if_public_write(char *filepath) {
    
    struct stat file_stat;
    if (stat(filepath, &file_stat) != 0) {
        perror("stat");
        exit(EXIT_FAILURE);
    };
    mode_t file_mode = file_stat.st_mode;
    if ((file_mode & S_IWOTH) == S_IWOTH) {
    // if (S_IWOTH(file_mode)) {
        printf("removing public write from %s\n", filepath);
        mode_t updated_mode = file_mode & (~S_IWOTH);
        if (chmod(filepath, updated_mode) != 0) {
            perror("chmod");
            exit(EXIT_FAILURE);
        }
    } else {
        printf("%s is not publically writable\n", filepath); 
    }
}

int main(int argc, char *argv[]) {
    if (argc < 2) {
        fprintf(stderr, "usage: %s <file_name>", argv[0]);
        exit(EXIT_FAILURE);
    }

    for (int arg = 1; arg < argc; arg++) {
        chmod_if_public_write(argv[arg]);
    }


    return 0;
}