/**
 * Convert a binary file into dat ascii-hex format
 *
 * Date: Dec 25th 2018
 * Author: Jorge Oliveira
 * License: Public Domain
 *
 * No warranties or guarantees express or implied.
 */

#include <stdio.h>
#include <stdlib.h>

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
		printf("ERROR: Unable to open file for read: %s\n", argv[1]);
		return 1;
	}

	// Open out for writing
	out = fopen(argv[2], "wb");
	if (out == NULL) {
		fclose(in); // Don't leak descriptors

		printf("ERROR: Unable to open file for write: %s\n", argv[2]);
		return 1;
	}

	// Initialize counters
	read = 0;
	count = 0;

	do {
		// Read in four byte chunks
		unsigned int buffer = 0;
		read = fread(&buffer, 1, sizeof(buffer), in);

		// Check for EOF and invalid reads
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

	// Check for unaligned reads
	if(count % 4) {
		printf("WARN: Unaligned read from: %s\n", argv[1]);
		fwrite("\n", 1, 1, out);
	}

	// Flush output
	fflush(out);

	// We're done, close descriptors
	fclose(out);
	fclose(in);

	return 0;
}