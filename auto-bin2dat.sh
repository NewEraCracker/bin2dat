#!/bin/sh

# Creates the microcode.dat from an intel-ucode folder
#
# Date: Dec 25th 2018
# Author: Jorge Oliveira
# License: Public Domain
#
# No warranties or guarantees express or implied.

# Configurable variables
CPUID_EXE=./cpuid
BIN2DAT_EXE=./bin2dat
INTEL_MC_DIR=./intel-ucode
MC_FILE='*'

# Uncomment the next two lines to build the executables
# gcc -o "${CPUID_EXE}" -O2 "${CPUID_EXE}".c
# gcc -o "${BIN2DAT_EXE}" -O2 "${BIN2DAT_EXE}".c

# Uncomment the next line if you know what you're doing
# MC_FILE="$("${CPUID_EXE}" | tr -d '\(\)' | awk '{print $2}')"

# List all files in microcode dir
find "${INTEL_MC_DIR}" -maxdepth 1 -type f -name "${MC_FILE}" -print | sort | while read filename; do

  # Convert
  "${BIN2DAT_EXE}" "${filename}" "${filename}.dat" 1>&2

  # Header
  echo "/*  $(basename "${filename}").dat  */"

  # Body
  cat "${filename}.dat"

  # Clean
  rm "${filename}.dat"

# Save in microcode.dat
done > microcode.dat