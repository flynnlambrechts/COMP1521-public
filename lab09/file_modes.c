#include <unistd.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <stdio.h>
#include <stdlib.h>

int main(int argc, char *argv[]) {
    for (int arg = 1; arg < argc; arg++) {
        struct stat s;
        if (stat(argv[arg], &s) != 0) {
            perror(argv[arg]);
            exit(1);
        }


        int mode = s.st_mode;
        if (!S_ISREG(mode)) {
            printf("d");
        } else {
            printf("-");
        }

        int nPerms = 9;
        int perms[] = {S_IRUSR, S_IWUSR, S_IXUSR, S_IRGRP, S_IWGRP, S_IXGRP, S_IROTH, S_IWOTH, S_IXOTH};
        int types[3] = {'r', 'w', 'x'};

        for (int i = 0; i < nPerms; i++) {
            if (mode & perms[i]) {
                printf("%c", types[i % 3]);
            } else {
                printf("-");
            }
        }
        printf(" %s\n", argv[arg]);
    }
}