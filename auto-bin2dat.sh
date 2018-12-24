#!/bin/sh

# Creates the microcode.dat from an intel-ucode folder
#
# Date: Dec 24th 2018
# Author: Jorge Oliveira
# License: Public Domain
#
# No warranties or guarantees express or implied.

# Configurable variables
BIN_DAT_EXE=./bin2dat
INTEL_MC_DIR=./intel-ucode

# List all files in microcode dir
find "${INTEL_MC_DIR}" -type f -print | while read filename; do

  # Header
  echo "/*  ${filename}.dat  */"

  # Convert
  "${BIN_DAT_EXE}" "${filename}" "${filename}.dat" | tee 1>&2

  # Body
  cat "${filename}.dat"

  # Clean
  rm "${filename}.dat"

# Save in microcode.dat
done > microcode.dat