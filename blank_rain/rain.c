////////////////////////////////////////////////////////////////////////
// COMP1521 23T1 --- Assignment 2: `rain', a simple file archiver
// <https://www.cse.unsw.edu.au/~cs1521/23T1/assignments/ass2/index.html>
//
// Written by YOUR-NAME-HERE (z5555555) on INSERT-DATE-HERE.
//
// 2021-11-08   v1.1    Team COMP1521 <cs1521 at cse.unsw.edu.au>

#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include <assert.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <unistd.h>

#include "rain.h"


// ADD ANY extra #defines HERE


// ADD YOUR FUNCTION PROTOTYPES HERE


// print the files & directories stored in drop_pathname (subset 0)
//
// if long_listing is non-zero then file/directory permissions, formats & sizes are also printed (subset 0)

void list_drop(char *drop_pathname, int long_listing) {

    // REPLACE THIS CODE WITH YOUR CODE

    printf("list_drop called to list drop: '%s'\n", drop_pathname);

    if (long_listing) {
        printf("long listing with permissions & sizes specified\n");
    }
}


// check the files & directories stored in drop_pathname (subset 1)
//
// prints the files & directories stored in drop_pathname with a message
// either, indicating the hash byte is correct, or
// indicating the hash byte is incorrect, what the incorrect value is and the correct value would be

void check_drop(char *drop_pathname) {

    // REPLACE THIS PRINTF WITH YOUR CODE

    printf("check_drop called to check drop: '%s'\n", drop_pathname);
}


// extract the files/directories stored in drop_pathname (subset 2 & 3)

void extract_drop(char *drop_pathname) {

    // REPLACE THIS PRINTF WITH YOUR CODE

    printf("extract_drop called to extract drop: '%s'\n", drop_pathname);
}


// create drop_pathname containing the files or directories specified in pathnames (subset 3)
//
// if append is zero drop_pathname should be over-written if it exists
// if append is non-zero droplets should be instead appended to drop_pathname if it exists
//
// format specifies the droplet format to use, it must be one DROPLET_FMT_6,DROPLET_FMT_7 or DROPLET_FMT_8

void create_drop(char *drop_pathname, int append, int format,
                int n_pathnames, char *pathnames[n_pathnames]) {

    // REPLACE THIS CODE PRINTFS WITH YOUR CODE

    printf("create_drop called to create drop: '%s'\n", drop_pathname);
    printf("format = %x\n", format);
    printf("append = %d\n", append);
    printf("These %d pathnames specified:\n", n_pathnames);
    for (int p = 0; p < n_pathnames; p++) {
        printf("%s\n", pathnames[p]);
    }
}


// ADD YOUR EXTRA FUNCTIONS HERE
