#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <string.h>

int main(int argc, char * argv[])
{
	if (argc < 3) {
		printf("Usage: %s <microcode.bin> <microcode.dat>\n", argv[0]);
		return 1;
	}

	FILE * in = fopen(argv[1], "rb");

	if (in == NULL) {
		printf("Unable to open file for read: %s\n", argv[1]);
		return 1;
	}

	FILE * out = fopen(argv[2], "wb");

	if (out == NULL) {
		printf("Unable to open file for write: %s\n", argv[2]);
		return 1;
	}

	int read = 0;
	int count = 0;

	do {
		int32_t buffer = 0;
		read = fread(&buffer, 1, sizeof(buffer), in);

		if (!read) {
			break;
		} else if(read != 4) {
			printf("WARN: Invalid read from: %s\n", argv[1]);
		}

		fprintf(out, "0x%08x,", buffer);
		fflush(out);

		if(++count % 4) {
			fwrite(" ", 1, 1, out);
		} else {
			fwrite("\n", 1, 1, out);
		}

		fflush(out);
	} while (read);

	fclose(out);
	fclose(in);
}