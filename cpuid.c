/**
 * Discover the cpuid of an Intel processor
 *
 * Date: Dec 25th 2018
 * Author: Jorge Oliveira
 * License: Public Domain
 *
 * No warranties or guarantees express or implied.
 */

#include <stdio.h>
#include <stdlib.h>

unsigned int cpuid(unsigned int type)
{
	unsigned int id = type;

#ifndef _MSC_VER
	__asm__("cpuid" : "=a" (id) : "a" (id));
#else
	__asm {
		mov eax, id
		cpuid
		mov id, eax
	}
#endif

	return id;
}

int main(int argc, char * argv[])
{
	unsigned int id = cpuid(1);

	unsigned char step = (id) & 0x0000000f;
	unsigned char model = (((id >> 16) & 0x000000ff) << 4) | ((id >> 4) & 0x0000000f);
	unsigned char family = (((id >> 20) & 0x000000ff) << 4) | ((id >> 8) & 0x0000000f);

	printf("%08x (%02x-%02x-%02x)", id, family, model, step);

	fflush(stdout);
	return 0;
}