
Convert .bin files into various .dat files and/or a single one:

    /**
     * Date: Dec 26th 2018
     * Author: Jorge "NewEraCracker" Oliveira
     * License: Unlicense (Public Domain)
     * URL: https://github.com/NewEraCracker/bin2dat
     *
     * No warranties or guarantees express or implied.
     */

## auto-bin2dat
Creates the microcode.dat from an intel-ucode folder.

Read the source code, usage examples in comments. 

## bin2dat
Convert a binary file into dat ascii-hex format.

Usage: bin2dat <microcode.bin> <microcode.dat>

## cpuid
Discover the cpuid of an Intel processor

## Build utilities from source:

cl:

    cl -o bin2dat.exe -O2 bin2dat.c
    cl -o cpuid.exe -O2 cpuid.c

gcc:

    gcc -o bin2dat -O2 bin2dat.c
    gcc -o cpuid -O2 cpuid.c
