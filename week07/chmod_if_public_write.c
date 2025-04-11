#include <stdio.h>
#include <sys/stat.h>

int main(int argc, char *argv[]) {
    for (int i = 1; i < argc; ++i) {
        struct stat s;
        stat(argv[i], &s);

        if (s.st_mode & S_IWOTH) {
            printf("removing public write from %s", argv[i]);
            // chmod
        } else {
            printf("%s is not publically writable", argv[i]);
        }
    }
    return 0;
}