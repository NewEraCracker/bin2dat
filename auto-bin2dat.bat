@REM Creates the microcode.dat from an intel-ucode folder
@REM
@REM Date: Dec 25th 2018
@REM Author: Jorge Oliveira
@REM License: Public Domain
@REM
@REM No warranties or guarantees express or implied.

set CPUID_EXE=.\cpuid
set BIN2DAT_EXE=.\bin2dat
set INTEL_MC_DIR=.\intel-ucode
set MC_FILE=*

@REM Uncomment the next two lines to build the executables
@REM gcc -o "%CPUID_EXE%" -O2 "%CPUID_EXE%.c"
@REM gcc -o "%BIN2DAT_EXE%" -O2 "%BIN2DAT_EXE%.c"

@REM Uncomment the next two lines if you know what you're doing
@REM for /f "tokens=2 delims=(" %%a in ('%CPUID_EXE%') do set MC_FILE=%%a
@REM set MC_FILE=%MC_FILE:~0,-1%

@REM List all files in microcode dir
echo. 1>nul 2>microcode.dat
for /F "tokens=*" %%a in ('dir /b "%INTEL_MC_DIR%\%MC_FILE%"') do (

  @REM Convert
  "%BIN2DAT_EXE%" "%INTEL_MC_DIR%\%%a" "%INTEL_MC_DIR%\%%a.dat" 1>&2

  @REM Header
  echo /*  %%a  */

  @REM Body
  type "%INTEL_MC_DIR%\%%a.dat"

  @REM Clean
  del "%INTEL_MC_DIR%\%%a.dat"

@REM Save in microcode.dat
) >> microcode.dat