/**
 * Converts a blob of binary data into dat (ASCII-HEX) format
 *
 * Date: Dec 24th 2018
 * Author: Jorge Oliveira
 * License: Public Domain
 *
 * No warranties or guarantees express or implied.
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#ifndef _MSC_VER
#include <stdint.h>
#else
#define int32_t __int32
#endif

int main(int argc, char * argv[])
{
	// Declare variables for C89
	int read, count;
	FILE *in, *out;

	// Check number of arguments
	if (argc != 3) {
		printf("Usage: %s <microcode.bin> <microcode.dat>\n", argv[0]);
		return 1;
	}

	// Open in for reading
	in = fopen(argv[1], "rb");
	if (in == NULL) {
		printf("Unable to open file for read: %s\n", argv[1]);
		return 1;
	}

	// Open out for writing
	out = fopen(argv[2], "wb");
	if (out == NULL) {
		fclose(in); // Don't leak descriptors

		printf("Unable to open file for write: %s\n", argv[2]);
		return 1;
	}

	// Initialize counters
	read = 0;
	count = 0;

	do {
		// Read in four byte chunks
		int32_t buffer = 0;
		read = fread(&buffer, 1, sizeof(buffer), in);

		if (!read) {
			break;
		} else if(read != 4) {
			printf("WARN: Invalid read from: %s\n", argv[1]);
		}

		// Output conversion result
		fprintf(out, "0x%08x,", buffer);

		// Whitespace
		if(++count % 4) {
			fwrite(" ", 1, 1, out);
		} else {
			fwrite("\n", 1, 1, out);
		}
	} while (read);

	// Flush output
	fflush(out);

	// We're done, close descriptors
	fclose(out);
	fclose(in);

	return 0;
}