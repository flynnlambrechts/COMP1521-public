#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <unistd.h>

int main(int argc, char **argv) {
    int nInodes = 0;
    int inodes[argc - 1];
    for (int arg = 1; arg < argc; arg++) {
        struct stat stats;
        stat(argv[arg], &stats);
        int found = 0;
        for (int i = 0; i < nInodes; i++) {
            if (inodes[i] == stats.st_ino) {
                found = 1;
            }
        }
        if (found == 0) {
            inodes[nInodes] = stats.st_ino;
            nInodes++;
            printf("%s\n", argv[arg]);
        }
    }
    
    return EXIT_SUCCESS;
}
