@REM For updates please check: https://github.com/NewEraCracker/bin2dat
@REM
@REM Creates the microcode.dat from an intel-ucode folder
@REM
@REM Date: Dec 25th 2018
@REM Author: Jorge Oliveira
@REM License: Public Domain
@REM
@REM No warranties or guarantees express or implied.

@REM Configurable variables
set CPUID_EXE=.\cpuid
set BIN2DAT_EXE=.\bin2dat
set INTEL_UC_DIR=.\intel-ucode

@REM Set to * for all, or empty for automatic detection
set UC_FILE=*

@REM Uncomment the next three lines to build the executables
@REM set GCC_EXE=cl
@REM "%GCC_EXE%" -o "%CPUID_EXE%" -O2 "%CPUID_EXE%.c"
@REM "%GCC_EXE%" -o "%BIN2DAT_EXE%" -O2 "%BIN2DAT_EXE%.c"

@REM Determine microcode file name
if _%UC_FILE%_==__ for /f "tokens=2 delims=()" %%a in ('%CPUID_EXE%') do set UC_FILE=%%a

@REM Blank the destination file
echo. 1>nul 2>microcode.dat

@REM List matching files in microcode dir
for /F "tokens=*" %%a in ('dir /b "%INTEL_UC_DIR%\%UC_FILE%"') do (

  @REM Convert
  "%BIN2DAT_EXE%" "%INTEL_UC_DIR%\%%a" "%INTEL_UC_DIR%\%%a.dat" 1>&2

  @REM Header
  echo /*  %%a  */

  @REM Body
  type "%INTEL_UC_DIR%\%%a.dat"

  @REM Clean
  del "%INTEL_UC_DIR%\%%a.dat"

@REM Save in microcode.dat
) >> microcode.dat