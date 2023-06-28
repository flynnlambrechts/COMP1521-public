#include <string.h>
#include <stdlib.h>
#include <stdio.h>
#include <stdint.h>
/**
 * given a `UTF-8` encoded string,
 * return a new string that is only
 * the characters within the provided range.
 *
 * Note:
 * `range_start` is INCLUSIVE
 * `range_end`   is EXCLUSIVE
 *
 * eg:
 * "hello world", 0, 5
 * would return "hello"
 *
 * "🍓🍇🍈🍍🍐", 2, 5
 * would return "🍈🍍🍐"
**/

char *_22t2final_q6(char *utf8_string, unsigned int range_start, unsigned int range_end) {
	// char *new_string = malloc(sizeof(char) * (range_end - range_start + 2));
	char *new_string = strdup(utf8_string);
	int nbyte = 0;
	int nbytes_copied = 0;
	for (int i = 0; i < range_end; i++) {		
		uint8_t byte = utf8_string[nbyte];
		int nbytes;
		if (byte < 0x80) {
			nbytes = 1;
		} else if (byte < 0xe0) {
			nbytes = 2;
		} else if (byte < 0xf0) {
			nbytes = 3;
		} else {
			nbytes = 4;
		}
		if (i >= range_start) {
			for (int j = 0; j < nbytes; j++) {
				new_string[nbytes_copied] = utf8_string[nbyte];
				nbytes_copied++;
				nbyte++;
			}
		} else {
			nbyte += nbytes;
		}
	}
	new_string[nbytes_copied] = '\0';
	return new_string;
}
