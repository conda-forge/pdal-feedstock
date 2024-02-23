@echo on

:: Create temporary prefix to be able to install files more granularly
mkdir temp_prefix

cmake --install ./build --prefix=./temp_prefix

move .\temp_prefix\lib\libpdalcpp.lib %LIBRARY_LIB%
move .\temp_prefix\bin\libpdalcpp.dll %LIBRARY_BIN%
move .\temp_prefix\bin\pdal.exe %LIBRARY_BIN%
copy .\temp_prefix\lib\pkgconfig\pdal.pc %LIBRARY_LIB%\pkgconfig
mkdir %LIBRARY_LIB%\cmake\PDAL
move .\temp_prefix\lib\cmake\PDAL\* %LIBRARY_LIB%\cmake\PDAL
mkdir %LIBRARY_PREFIX%\include\pdal
xcopy /s /y .\temp_prefix\include\pdal %LIBRARY_PREFIX%\include\pdal

set ACTIVATE_DIR=%PREFIX%\etc\conda\activate.d
set DEACTIVATE_DIR=%PREFIX%\etc\conda\deactivate.d
mkdir %ACTIVATE_DIR%
mkdir %DEACTIVATE_DIR%

copy %RECIPE_DIR%\scripts\%%change.bat %ACTIVATE_DIR%\pdal-activate.bat
if errorlevel 1 exit 1

copy %RECIPE_DIR%\scripts\deactivate.bat %DEACTIVATE_DIR%\pdal-deactivate.bat
if errorlevel 1 exit 1

:: Copy unix shell activation scripts, needed by Windows Bash users
copy %RECIPE_DIR%\scripts\activate.sh %ACTIVATE_DIR%\pdal-activate.sh
if errorlevel 1 exit 1

copy %RECIPE_DIR%\scripts\deactivate.sh %DEACTIVATE_DIR%\pdal-deactivate.sh
if errorlevel 1 exit 1

:: Copy power shell activation scripts
copy %RECIPE_DIR%\scripts\activate.ps1 %ACTIVATE_DIR%\pdal-activate.ps1
if errorlevel 1 exit 1

copy %RECIPE_DIR%\scripts\deactivate.ps1 %DEACTIVATE_DIR%\pdal-deactivate.ps1
if errorlevel 1 exit 1



:: clean up temp_prefix between builds
rmdir /s /q temp_prefix
