#!/bin/sh

# Creates the microcode.dat from an intel-ucode folder
#
# Date: Dec 25th 2018
# Author: Jorge Oliveira
# License: Public Domain
# URL: https://github.com/NewEraCracker/bin2dat
#
# No warranties or guarantees express or implied.

# Configurable variables
CPUID_EXE=./cpuid
BIN2DAT_EXE=./bin2dat
INTEL_UC_DIR=./intel-ucode

# Set to '*' for all, or '' for automatic detection
UC_FILE='*'

# Uncomment the next three lines to build the executables
# GCC_EXE=gcc
# "${GCC_EXE}" -o "${CPUID_EXE}" -O2 "${CPUID_EXE}".c
# "${GCC_EXE}" -o "${BIN2DAT_EXE}" -O2 "${BIN2DAT_EXE}".c

# Determine microcode file name
if [ -z "${UC_FILE}" ]; then
  UC_FILE="$("${CPUID_EXE}" | tr -d '\(\)' | awk '{print $2}')"
fi

# List matching files in microcode dir
find "${INTEL_UC_DIR}" -maxdepth 1 -type f -name "${UC_FILE}" -print | sort | while read filename; do

  # Convert
  "${BIN2DAT_EXE}" "${filename}" "${filename}.dat" 1>&2

  # Header
  printf '%s\r\n' "/*  $(basename "${filename}")  */"

  # Body
  cat "${filename}.dat"

  # Clean
  rm "${filename}.dat"

# Save in microcode.dat
done > microcode.dat