////////////////////////////////////////////////////////////////////////
// COMP1521 23T1 --- Assignment 2: `rain', a simple file archiver
// <https://www.cse.unsw.edu.au/~cs1521/23T1/assignments/ass2/index.html>
//
// Written by FLYNN-LAMBRECJTS (z5360922) on 13-06-2022.
//
// 2021-11-08   v1.1    Team COMP1521 <cs1521 at cse.unsw.edu.au>
//
// This program is a file archiever for the .drop format. It implements,
// 8 bit, 7 bit and 6 bit formatting.

#include <assert.h>
#include <dirent.h>
#include <math.h>
#include <stdbool.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <unistd.h>

#include "rain.h"

#define BYTE_SIZE 8
#define PATH_MAX  4096

const int PERMS[] = {S_IRUSR, S_IWUSR, S_IXUSR, S_IRGRP, S_IWGRP,
                     S_IXGRP, S_IROTH, S_IWOTH, S_IXOTH};
const int PERM_TYPES[3] = {'r', 'w', 'x'};

typedef struct droplet {
    uint8_t format;
    char *permissions;
    uint16_t nameLength;
    char *name;
    uint64_t contentLength;
    uint8_t hash;
    uint64_t length;
} Droplet;

static FILE *fopenErrorChecked(char *filepath, char *mode);
static int fgetcErrorChecked(FILE *stream, char *filename);
static void fseekErrorChecked(FILE *stream, long offset, int whence,
                              char *filename);
static void fseekoErrorChecked(FILE *stream, off_t offset, int whence,
                               char *filename);
static bool checkIsDrop(FILE *file);
static uint8_t getFormat(FILE *drop, char *dropPathname);
static void getPermissions(FILE *drop, char *permissions, char *dropPathname);
static uint16_t getFileNameLength(FILE *drop, char *dropPathname);
static void getFileName(FILE *drop, char *name, uint16_t length,
                        char *dropPathname);
static uint64_t getContentLength(FILE *drop, char *dropPathname);
static uint8_t getHash(FILE *drop, char *dropPathname);
static Droplet DropletFromDrop(FILE *drop, char *dropPathname);
static uint64_t DropletLength(Droplet droplet);
static void DropletFree(Droplet droplet);
static uint8_t calculateHash(FILE *droplet, int length, char *filename);
static void updatehash(FILE *droplet, uint8_t *currentHash, char *filename);
static mode_t parseMode(char *permissions);
static Droplet dropletFromFile(char *pathname, int format);
static char *permissionsFromMode(mode_t mode);
static void dropPutDroplet(Droplet droplet, FILE *drop, int format,
                           char *dropPathname);
static void fputcErrorChecked(int c, FILE *stream, char *filename);
static void fputsErrorChecked(char *s, FILE *stream, char *filename);
static void putLittleEndian(uint64_t bytes, int length, FILE *stream,
                            char *filename);
static bool dropletIsDirec(struct droplet droplet);
static void addAllFilesInDirec(FILE *drop, char *pathName, int format,
                               char *dropPathname);
static void dropPutContent(Droplet droplet, FILE *drop, int format,
                           char *dropPathname);
static void packBytesIntoDrop(FILE *drop, char *sourcePath, int length,
                              int nBits, char *dropPath);
static int dropletNContentBytes(Droplet droplet);
static void filePutDroplet(Droplet droplet, char *destPath, FILE *drop,
                           char *dropPath);
static void unpackBytesFromDrop(char *destPath, FILE *drop, char *dropPath,
                                int length, int nBits);

// print the files & directories stored in dropPathname (subset 0)
//
// if longListing is non-zero then file/directory permissions, formats & sizes are also printed (subset 0)

void list_drop(char *dropPathname, int longListing) {
    FILE *drop = fopenErrorChecked(dropPathname, "r");

    while (checkIsDrop(drop)) {
        Droplet droplet = DropletFromDrop(drop, dropPathname);

        if (longListing) {
            printf("%s %2c %6lu  %s\n", droplet.permissions, droplet.format,
                   droplet.contentLength, droplet.name);
        } else {
            printf("%s\n", droplet.name);
        }
        DropletFree(droplet);
    }

    fclose(drop);
}

// check the files & directories stored in dropPathname (subset 1)
//
// prints the files & directories stored in dropPathname with a message
// either, indicating the hash byte is correct, or
// indicating the hash byte is incorrect, what the incorrect value is and the correct value would be

void check_drop(char *dropPathname) {
    FILE *drop = fopenErrorChecked(dropPathname, "r");

    while (checkIsDrop(drop)) {
        Droplet droplet = DropletFromDrop(drop, dropPathname);
        fseek(drop, -droplet.length, SEEK_CUR);

        uint8_t hash = calculateHash(drop, droplet.length, dropPathname);

        printf("%s - ", droplet.name);
        if (hash != droplet.hash) {
            printf("incorrect hash 0x%x should be 0x%x\n", hash, droplet.hash);
        } else {
            printf("correct hash\n");
        }
        DropletFree(droplet);
        fseek(drop, DROP_LENGTH_HASH, SEEK_CUR);
    }
    fclose(drop);
}

// extract the files/directories stored in dropPathname (subset 2 & 3)

void extract_drop(char *dropPathname) {
    FILE *drop = fopenErrorChecked(dropPathname, "r");

    while (checkIsDrop(drop)) {
        Droplet droplet = DropletFromDrop(drop, dropPathname);

        if (dropletIsDirec(droplet)) {
            printf("Creating directory: %s\n", droplet.name);
            mkdir(droplet.name, parseMode(droplet.permissions));

            DropletFree(droplet);
            continue;
        }

        printf("Extracting: %s\n", droplet.name);

        int pathDepth = -1;
        char *pathstep = strtok(droplet.name, "/");
        char filename[PATH_MAX];
        while (pathstep != NULL) {
            chdir(pathstep);
            pathDepth++;
            strcpy(filename, pathstep);
            pathstep = strtok(NULL, "/");
        }

        FILE *dropletDestination = fopenErrorChecked(filename, "w");

        off_t offset = -(DROP_LENGTH_HASH + dropletNContentBytes(droplet));
        fseeko(drop, offset, SEEK_CUR);

        filePutDroplet(droplet, filename, drop, dropPathname);

        mode_t mode = parseMode(droplet.permissions);
        if (chmod(filename, mode) != 0) {
            perror(droplet.name);
            exit(1);
        };

        offset = DROP_LENGTH_HASH;
        fseeko(drop, offset, SEEK_CUR);
        DropletFree(droplet);
        fclose(dropletDestination);

        for (int i = 0; i < pathDepth; i++) {
            chdir("..");
        }
    }
    fclose(drop);
}

// create dropPathname containing the files or directories specified in pathnames (subset 3)
//
// if append is zero dropPathname should be over-written if it exists
// if append is non-zero droplets should be instead appended to dropPathname if it exists
//
// format specifies the droplet format to use, it must be one DROPLET_FMT_6,DROPLET_FMT_7 or DROPLET_FMT_8

void create_drop(char *dropPathname, int append, int format, int nPathnames,
                 char *pathnames[nPathnames]) {
    char *mode = (append == 0) ? "w+" : "a+";
    FILE *drop = fopenErrorChecked(dropPathname, mode);
    for (int p = 0; p < nPathnames; p++) {
        char pathName[PATH_MAX] = "";
        char *pathstep = strtok(pathnames[p], "/");

        bool pathIsDirec = true;
        while (pathstep != NULL) {
            strcat(pathName, pathstep);

            Droplet droplet = dropletFromFile(pathName, format);

            dropPutDroplet(droplet, drop, format, dropPathname);
            printf("Adding: %s\n", droplet.name);

            pathIsDirec = dropletIsDirec(droplet);
            DropletFree(droplet);

            strcat(pathName, "/");

            pathstep = strtok(NULL, "/");
        }

        if (pathIsDirec) {
            addAllFilesInDirec(drop, pathName, format, dropPathname);
        }
    }
    fclose(drop);
}

/**
 * Runs fopen but adds and extra check to see if it was run sucessfully.
 * If not prints the error.
 */
FILE *fopenErrorChecked(char *filepath, char *mode) {
    FILE *f = fopen(filepath, mode);
    if (f == NULL) {
        perror(filepath);
        exit(1);
    }
    return f;
}

/**
 * Runs fgetc but adds and extra check to see if it was run sucessfully.
 * If not prints the error.
 */
int fgetcErrorChecked(FILE *stream, char *filename) {
    int c = fgetc(stream);
    if (c == EOF) {
        perror(filename);
        exit(1);
    }
    return c;
}

/**
 * Runs fseek but adds and extra check to see if it was run sucessfully.
 */
void fseekErrorChecked(FILE *stream, long offset, int whence, char *filename) {
    if (fseek(stream, offset, whence) == -1) {
        perror(filename);
        exit(1);
    }
}

/**
 * Runs fseeko but adds and extra check to see if it was run sucessfully.
 */
void fseekoErrorChecked(FILE *stream, off_t offset, int whence,
                        char *filename) {
    if (fseeko(stream, offset, whence) == -1) {
        perror(filename);
        exit(1);
    }
}

/**
 * Runs fputc but adds and extra check to see if it was run sucessfully.
 * If not prints the error
 */
void fputcErrorChecked(int c, FILE *stream, char *filename) {
    if (fputc(c, stream) == EOF) {
        perror(filename);
        exit(1);
    }
}

/**
 * Runs fputs but adds and extra check to see if it was run sucessfully.
 * If not prints the error
 */
void fputsErrorChecked(char *s, FILE *stream, char *filename) {
    if (fputs(s, stream) == EOF) {
        perror(filename);
        exit(1);
    }
}

/**
 * Given the cursor is pointing to the first byte in the droplet. Returns true 
 * if the droplet's first byte is the drop magic number. Otherwise returns 
 * false.
 * After running, cursor will point to the bytes after.
 */
bool checkIsDrop(FILE *file) {
    int magicNumber = fgetc(file);
    if (magicNumber == EOF) {
        return false;
    } else if (magicNumber != DROPLET_MAGIC) {
        fprintf(stderr,
                "error: incorrect first droplet byte: 0x%x should be 0x%x\n",
                magicNumber, DROPLET_MAGIC);
        return false;
    }
    return true;
}

/**
 * Given the cursor is pointing to the position of the format specifier in the
 * droplet: returns the format specifier.
 * After running, cursor will point to the bytes after.
 */
uint8_t getFormat(FILE *drop, char *dropPathname) {
    uint8_t formatSpecifer = fgetcErrorChecked(drop, dropPathname);
    return formatSpecifer;
}

/**
 * Given the cursor is pointing to the position of the permission specifier in 
 * the droplet: updates the permmission argument.
 * After running, cursor will point to the bytes after.
 */
void getPermissions(FILE *drop, char *permissions, char *dropPathname) {
    for (int i = 0; i < DROP_LENGTH_MODE; i++) {
        permissions[i] = fgetcErrorChecked(drop, dropPathname);
    }
    permissions[DROP_LENGTH_MODE] = '\0';
}

/**
 * Given the cursor is pointing to the position of the file name length in the
 * droplet: returns the the file name length.
 * After running, cursor will point to the bytes after.
 */
uint16_t getFileNameLength(FILE *drop, char *dropPathname) {
    uint16_t fileNameLength;
    fileNameLength = fgetcErrorChecked(drop, dropPathname);
    fileNameLength += (fgetcErrorChecked(drop, dropPathname) << 8);
    return fileNameLength;
}

/**
 * Given the file name length and that the cursor points to the filename
 * updates the name argument.
 * After running, cursor will point to the bytes after.
 */
void getFileName(FILE *drop, char *name, uint16_t length, char *dropPathname) {
    for (int i = 0; i < length; i++) {
        name[i] = fgetcErrorChecked(drop, dropPathname);
    }
    name[length] = '\0';
}

/**
 * Given the cursor is pointing to the position of the content length in the
 * droplet: returns the the content length.
 * After running, cursor will point to the bytes after.
 */
uint64_t getContentLength(FILE *drop, char *dropPathname) {
    uint64_t contentLength = 0;
    for (int i = 0; i < DROP_LENGTH_CONTLEN; i++) {
        uint64_t byte = fgetcErrorChecked(drop, dropPathname);
        contentLength += (byte << (BYTE_SIZE * i));
    }
    return contentLength;
}

/**
 * Given the cursor is pointing to the position of the hash in the
 * droplet: returns the the hash.
 * After running, cursor will point to the bytes after.
 */
uint8_t getHash(FILE *drop, char *dropPathname) {
    uint8_t hash = fgetcErrorChecked(drop, dropPathname);
    return hash;
}

/**
 * A constructor for a struct droplet, given a file pointing to the format
 * specifier of the dorp.
 * After running, cursor will point to the next droplet.
 */
Droplet DropletFromDrop(FILE *drop, char *dropPathname) {
    Droplet droplet;
    droplet.format = getFormat(drop, dropPathname);

    droplet.permissions = malloc(sizeof(char) * (DROP_LENGTH_MODE + 1));
    getPermissions(drop, droplet.permissions, dropPathname);

    droplet.nameLength = getFileNameLength(drop, dropPathname);

    droplet.name = malloc(sizeof(char) * (droplet.nameLength + 1));
    getFileName(drop, droplet.name, droplet.nameLength, dropPathname);

    droplet.contentLength = getContentLength(drop, dropPathname);

    off_t offset = dropletNContentBytes(droplet);

    fseeko(drop, offset, SEEK_CUR);
    droplet.hash = getHash(drop, dropPathname);
    droplet.length = DropletLength(droplet);
    return droplet;
}

/**
 * Calculates the number of bytes in the droplet excluding the magic number.
 */
uint64_t DropletLength(Droplet droplet) {
    return (DROP_LENGTH_FORMAT + DROP_LENGTH_MODE + DROP_LENGTH_PATHNLEN +
            DROP_LENGTH_CONTLEN + DROP_LENGTH_HASH + droplet.nameLength +
            dropletNContentBytes(droplet));
}

/**
 * Free all the malloced members of the struct.
 */
void DropletFree(Droplet droplet) {
    free(droplet.permissions);
    free(droplet.name);
}

/**
 * Given the cursor points to the format specifier of the droplet, calculates
 * the hash of the droplet.
 * After running, cursor will point to the next hash position.
 */
uint8_t calculateHash(FILE *droplet, int length, char *filename) {
    uint8_t *hash_ptr = malloc(sizeof(uint8_t));
    *hash_ptr = droplet_hash(0, DROPLET_MAGIC);

    for (int i = 0; i < length - 1; i++) {
        updatehash(droplet, hash_ptr, filename);
    }
    uint8_t hash = *hash_ptr;
    free(hash_ptr);
    return hash;
}

/**
 * Updates the hash argument with a updated hash considering the next byte in 
 * the file.
 */
void updatehash(FILE *droplet, uint8_t *currentHash, char *dropPathname) {
    *currentHash =
        droplet_hash(*currentHash, fgetcErrorChecked(droplet, dropPathname));
}

/**
 * Converts a permissions string into a mode number to be used by chmod.
 */
mode_t parseMode(char *permissions) {
    mode_t mode = 0;

    for (int i = 0; i < DROP_LENGTH_MODE - 1; i++) {
        if (permissions[i + 1] == PERM_TYPES[i % 3]) {
            mode |= PERMS[i];
        }
    }

    return mode;
}

/**
 * Given a regular file, converts this into a droplet struct.
 * After running, cursor will point to the next end of file.
 */
Droplet dropletFromFile(char *pathname, int format) {
    struct stat s;
    if (stat(pathname, &s) != 0) {
        perror(pathname);
        exit(1);
    }

    Droplet droplet;
    droplet.format = format;
    droplet.permissions = permissionsFromMode(s.st_mode);
    droplet.nameLength = strlen(pathname);
    droplet.name = malloc(sizeof(char) * (droplet.nameLength + 1));
    strcpy(droplet.name, pathname);

    FILE *dropletFile = fopenErrorChecked(pathname, "r");

    if (dropletIsDirec(droplet)) {
        droplet.contentLength = 0;
    } else {
        fseek(dropletFile, 0, SEEK_END);
        droplet.contentLength = ftell(dropletFile);
    }

    droplet.length = DropletLength(droplet);
    droplet.hash = 0;
    droplet.length = DropletLength(droplet);

    fclose(dropletFile);
    return droplet;
}

/**
 * From a mode number, constructs and returns the permissions string.
 */
char *permissionsFromMode(mode_t mode) {
    char *permissions = malloc(sizeof(char) * (DROP_LENGTH_MODE + 1));
    if (S_ISREG(mode)) {
        permissions[0] = '-';
    } else {
        permissions[0] = 'd';
    }
    for (int i = 0; i < DROP_LENGTH_MODE - 1; i++) {
        if (mode & PERMS[i]) {
            permissions[i + 1] = PERM_TYPES[i % 3];
        } else {
            permissions[i + 1] = '-';
        }
    }
    permissions[DROP_LENGTH_MODE] = '\0';
    return permissions;
}

/**
 * Given a .drop file, add a file into the .drop file.
 * After running, cursor will point to the next EOF.
 */
void dropPutDroplet(Droplet droplet, FILE *drop, int format,
                    char *dropPathname) {
    fputcErrorChecked(DROPLET_MAGIC, drop, droplet.name);
    fputcErrorChecked(droplet.format, drop, droplet.name);
    fputsErrorChecked(droplet.permissions, drop, droplet.name);
    putLittleEndian(droplet.nameLength, DROP_LENGTH_PATHNLEN, drop,
                    droplet.name);
    fputsErrorChecked(droplet.name, drop, droplet.name);
    putLittleEndian(droplet.contentLength, DROP_LENGTH_CONTLEN, drop,
                    droplet.name);

    dropPutContent(droplet, drop, format, dropPathname);

    fseekErrorChecked(drop, -(droplet.length - 1), SEEK_CUR, droplet.name);
    uint8_t hash = calculateHash(drop, droplet.length, droplet.name);
    fputcErrorChecked(hash, drop, droplet.name);
}

/**
 * Puts a multibyte number into a file in the little endian format.
 * After running, cursor will point to the next byte after.
 */
void putLittleEndian(uint64_t bytes, int length, FILE *stream, char *filename) {
    uint64_t mask = 0xFF;
    for (int i = 0; i < length; i++) {
        uint8_t byte = (mask & bytes) >> (BYTE_SIZE * i);
        fputcErrorChecked(byte, stream, filename);
        mask <<= BYTE_SIZE;
    }
}

/**
 * Returns true if a droplet is a directory, otherwise returns false.
 */
bool dropletIsDirec(struct droplet droplet) {
    return (droplet.permissions[0] == 'd');
}

/**
 * Given a directory adds all the files in that directory to the droplet.
 */
void addAllFilesInDirec(FILE *drop, char *pathName, int format,
                        char *dropPathname) {
    DIR *dirp = opendir(pathName);
    if (dirp == NULL) {
        perror(pathName);
        exit(1);
    }
    struct dirent *de;

    while ((de = readdir(dirp)) != NULL) {
        if ((strcmp(de->d_name, ".") == 0) || (strcmp(de->d_name, "..") == 0)) {
            continue;
        }
        char filePath[PATH_MAX];
        strcpy(filePath, pathName);
        strcat(filePath, de->d_name);
        Droplet droplet = dropletFromFile(filePath, format);

        dropPutDroplet(droplet, drop, format, dropPathname);
        printf("Adding: %s\n", droplet.name);

        if (dropletIsDirec(droplet)) {
            strcat(filePath, "/");
            addAllFilesInDirec(drop, filePath, format, dropPathname);
        }
    }
}

/**
 * Given a file and format outs the droplet's contents into the drop.
 * After running, cursor will point to the next bytes after.
 */
void dropPutContent(Droplet droplet, FILE *drop, int format,
                    char *dropPathname) {
    if (format == DROPLET_FMT_8) {
        FILE *dropletFile = fopenErrorChecked(droplet.name, "r");
        for (int i = 0; i < droplet.contentLength; i++) {
            int byte = fgetcErrorChecked(dropletFile, droplet.name);
            fputcErrorChecked(byte, drop, dropPathname);
        }
        fclose(dropletFile);
    } else if (format == DROPLET_FMT_7) {
        packBytesIntoDrop(drop, droplet.name, droplet.contentLength, 7,
                          dropPathname);
    } else if (format == DROPLET_FMT_6) {
        packBytesIntoDrop(drop, droplet.name, droplet.contentLength, 6,
                          dropPathname);
    } else {
        fprintf(stderr, "Bad drop format %c\n", format);
    }
}

/**
 * Packs the contnent bytes into n-bit (7 or 6) format in a drop.
 */
void packBytesIntoDrop(FILE *drop, char *sourcePath, int length, int nBits,
                       char *dropPath) {
    FILE *source = fopenErrorChecked(sourcePath, "r");
    uint8_t buffer = 0;
    int bufferBitsUsed = 0;

    for (int i = 0; i < length; i++) {
        int byte = fgetcErrorChecked(source, sourcePath);
        if (nBits == 6) {
            int tempByte = byte;
            byte = droplet_to_6_bit(byte);
            if (byte == -1) {
                fprintf(
                    stderr,
                    "error: byte 0x%x can not be represented in 6-bit format\n",
                    tempByte);
                exit(1);
            }
        } else if (nBits == 7 && (byte & ((uint8_t)1 << 7))) {
            fprintf(stderr,
                    "error: byte 0x%x can not be represented in 7-bit format\n",
                    byte);
            exit(1);
        }
        // Shift away leading zeros.
        byte <<= (BYTE_SIZE - nBits);

        for (int j = 0; j < nBits; j++) {
            uint8_t newBit = (byte & ((uint8_t)1 << 7)) >> 7;
            buffer <<= 1;
            buffer |= newBit;
            bufferBitsUsed++;

            if (bufferBitsUsed == BYTE_SIZE) {
                fputcErrorChecked(buffer, drop, dropPath);
                buffer = 0;
                bufferBitsUsed = 0;
            }
            byte <<= 1;
        }
    }

    if (bufferBitsUsed != 0) {
        buffer <<= (BYTE_SIZE - bufferBitsUsed);
        fputcErrorChecked(buffer, drop, dropPath);
    }
    fclose(source);
}

/**
 * Calculates and returns the real number of bytes used for the content of the 
 * drop, given it's packed (or not) format.
 */
int dropletNContentBytes(Droplet droplet) {
    double nBits = 0;
    switch (droplet.format) {
        case DROPLET_FMT_6: nBits = 6.0; break;
        case DROPLET_FMT_7: nBits = 7.0; break;
        case DROPLET_FMT_8: nBits = 8.0; break;
        default:
            fprintf(stderr, "Bad drop format %c\n", droplet.format);
            exit(1);
    }
    return ceil((nBits / 8.0) * droplet.contentLength);
}

/**
 * Given a droplet struct, puts that droplet into a the .drop file.
 * After running, cursor will point to EOF.
 */
void filePutDroplet(Droplet droplet, char *destPath, FILE *drop,
                    char *dropPath) {
    if (droplet.format == DROPLET_FMT_8) {
        FILE *dest = fopenErrorChecked(destPath, "w");
        for (int i = 0; i < droplet.contentLength; i++) {
            fputcErrorChecked(fgetcErrorChecked(drop, dropPath), dest,
                              destPath);
        }
        fclose(dest);
    } else if (droplet.format == DROPLET_FMT_7) {
        unpackBytesFromDrop(destPath, drop, dropPath, droplet.contentLength, 7);
    } else if (droplet.format == DROPLET_FMT_6) {
        unpackBytesFromDrop(destPath, drop, dropPath, droplet.contentLength, 6);
    }
}

/**
 * Given n-bit packing unpacks the bytes into their full format.
 */
void unpackBytesFromDrop(char *destPath, FILE *drop, char *dropPath, int length,
                         int nBits) {
    FILE *dest = fopenErrorChecked(destPath, "w");
    uint8_t buffer = fgetcErrorChecked(drop, dropPath);
    int bufferBitsRemaining = BYTE_SIZE;

    for (int i = 0; i < length; i++) {
        int byte = 0;
        for (int j = 0; j < nBits; j++) {
            uint8_t newBit = (buffer & ((uint8_t)1 << 7)) >> 7;
            byte <<= 1;
            byte |= newBit;
            bufferBitsRemaining--;

            buffer <<= 1;
            if (bufferBitsRemaining == 0) {
                buffer = fgetcErrorChecked(drop, dropPath);
                bufferBitsRemaining = BYTE_SIZE;
            }
        }

        if (nBits == 6) {
            int tempByte = byte;
            byte = droplet_from_6_bit(byte);
            if (byte == -1) {
                fprintf(stderr,
                        "error: byte 0x%x can not be represented in 6-bit, "
                        "format\n",
                        tempByte);
                exit(1);
            }
        }
        fputcErrorChecked(byte, dest, destPath);
    }
    if (bufferBitsRemaining == BYTE_SIZE) {
        fseek(drop, -1, SEEK_CUR);
    }
    fclose(dest);
}