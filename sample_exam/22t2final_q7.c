#include <string.h>
#include <dirent.h>
#include <stdio.h>
#include <stdlib.h>

#define PATH_MAX 4096

/**
 * Recursively find all files and directories
 * in `directory` that match the given criteria.
 *
 * Parameters:
 * `directory`: The starting directory to begin
 *              the search. This parameter will
 *              always be provided (i.e. never NULL).
 *
 * `name`:      If provided, any printed files or
 *              directories must have this name.
 *              Note that you should still search through
 *              directories that do not match `name`.
 *              If not provided (i.e. name == NULL),
 *              there are no restrictions on the name.
 *
 * `min_depth`: If provided, any printed files or
 *              directories must occur at least `min_depth`
 *              directories deep.
 *              Any files or directories existing in the
 *              provided `directory` are considered to be
 *              of depth 0.
 *              If not provided (i.e. min_depth == -1),
 *              there are no restrictions on minimum depth.
 *
 * `max_depth`: If provided, any printed files or
 *              directories must occur at most `max_depth`
 *              directories deep.
 *              Any files or directories existing in the
 *              provided `directory` are considered to be
 *              of depth 0.
 *              If not provided (i.e. max_depth == -1),
 *              there are no restrictions on maximum depth.
 */
void do_q7(char *directory, char *name, int min_depth, int max_depth, int depth);


void _22t2final_q7(char *directory, char *name, int min_depth, int max_depth) {
	do_q7(directory, name, min_depth, max_depth, 0);
}

void do_q7(char *directory, char *name, int min_depth, int max_depth, int depth) {
	// printf("%s\n", directory);
	DIR *dirp = opendir(directory);
	if (dirp == NULL) {
		perror(directory);
		exit(1);
	}

	if (max_depth != -1 && depth > max_depth) {
		return;
	}
	struct dirent *direc;
	// int direcFound = 0;
	while ((direc = readdir(dirp)) != NULL) {
		// if (strcmp(direc->d_name, ".") == 0 || strcmp(direc->d_name, "..") == 0) {
		// 	continue;
		// }

		char d_name[PATH_MAX];
		strcpy(d_name, directory);
		strcat(d_name, "/");
		strcat(d_name, direc->d_name);
		if (name == NULL || strcmp(direc->d_name, name) == 0) {
			if (min_depth == -1 || depth >= min_depth) {
				printf("%s\n", d_name);
			}
		}

		if (direc->d_type == DT_DIR) {
			// direcFound++;
			if (strcmp(direc->d_name, ".") != 0 && strcmp(direc->d_name, "..") != 0) {
				do_q7(d_name, name, min_depth, max_depth, depth + 1);
			}
		}

	}
	// if (direcFound == 0 && (name == NULL || strcmp(name, ".") == 0 || strcmp(name, "..") == 0)) {
	// 	if (min_depth == -1 || depth >= min_depth) {
	// 		char d_name[PATH_MAX];
	// 		strcpy(d_name, directory);
	// 		strcat(d_name, "/.");
	// 		printf("%s\n", d_name);
	// 		strcat(d_name, ".");
	// 		printf("%s\n", d_name);
	// 	}
	// }
	closedir(dirp);
}