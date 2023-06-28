#include <stdio.h>
#include <time.h>
#include <sys/stat.h>

int main(int argc, char* argv[]) {
    for (int arg = 1; arg < argc; arg++) {
        time_t now = time(NULL);
        struct stat s;
        stat(argv[arg], &s);
        if (s.st_mtime > now || s.st_atime > now) {
            printf("%s has a timestamp that is in the future\n", argv[arg]);
        }
    }

    
    return 0;
}