@echo on
setlocal ENABLEDELAYEDEXPANSION

:: Create temporary prefix to be able to install files more granularly
mkdir temp_prefix



echo "build PKG_NAME %PKG_NAME%"

if [%PKG_NAME%] == [libpdal] (

    cmake --install ./build --prefix=./temp_prefix

move .\temp_prefix\lib\pdalcpp.lib %LIBRARY_LIB%
move .\temp_prefix\bin\pdalcpp.dll %LIBRARY_BIN%
move .\temp_prefix\bin\pdal.exe %LIBRARY_BIN%
copy .\temp_prefix\lib\pkgconfig\pdal.pc %LIBRARY_LIB%\pkgconfig
mkdir %LIBRARY_LIB%\cmake\PDAL
move .\temp_prefix\lib\cmake\PDAL\* %LIBRARY_LIB%\cmake\PDAL
mkdir %LIBRARY_PREFIX%\include\pdal
xcopy /s /y .\temp_prefix\include\pdal %LIBRARY_PREFIX%\include\pdal


set "ACTIVATE_DIR=%PREFIX%\etc\conda\activate.d"
set "DEACTIVATE_DIR=%PREFIX%\etc\conda\deactivate.d"

REM because we set ACTIVATE_DIR in this conditional, we have to
REM use the !
mkdir !ACTIVATE_DIR!
mkdir !DEACTIVATE_DIR!

copy %RECIPE_DIR%\scripts\activate.bat !ACTIVATE_DIR!\pdal-activate.bat
if errorlevel 1 exit 1

copy %RECIPE_DIR%\scripts\deactivate.bat !DEACTIVATE_DIR!\pdal-deactivate.bat
if errorlevel 1 exit 1

:: Copy power shell activation scripts
copy %RECIPE_DIR%\scripts\activate.ps1 !ACTIVATE_DIR!\pdal-activate.ps1
if errorlevel 1 exit 1

copy %RECIPE_DIR%\scripts\deactivate.ps1 !DEACTIVATE_DIR!\pdal-deactivate.ps1
if errorlevel 1 exit 1

) else if [%PKG_NAME%] == [libpdal-hdf] (
    CALL :InstallPlugin "plugins\hdf"
    CALL :InstallPlugin "plugins\icebridge"
) else if [%PKG_NAME%] == [libpdal-tiledb] (
    CALL :InstallPlugin "plugins\tiledb"
) else if [%PKG_NAME%] == [libpdal-draco] (
    CALL :InstallPlugin "plugins\draco"
) else if [%PKG_NAME%] == [libpdal-pgpointcloud] (
    CALL :InstallPlugin "plugins\pgpointcloud"
) else if [%PKG_NAME%] == [libpdal-arrow] (
    CALL :InstallPlugin "plugins\arrow"
) else if [%PKG_NAME%] == [libpdal-nitf] (
    CALL :InstallPlugin "plugins\nitf"
) else if [%PKG_NAME%] == [libpdal-trajectory] (
    CALL :InstallPlugin "plugins\trajectory"
) else if [%PKG_NAME%] == [libpdal-nitf] (
    CALL :InstallPlugin "plugins\nitf"

) else if [%PKG_NAME%] == [libpdal-all] (
    REM do nothing
    dir
) else (
    REM shouldn't happen
    echo "Did not recognize %PKG_NAME%!"
    exit 1
)


:: clean up temp_prefix between builds
rmdir /s /q temp_prefix

GOTO :EOF


:InstallPlugin
echo "Installing plugin for directory %~1 "
set PLUGIN_DIR=%~1
echo "Set PLUGIN_DIR to !PLUGIN_DIR!"
pushd !PLUGIN_DIR!
cmake --install ./build --prefix=./temp_prefix
copy .\temp_prefix\bin\libpdal*.dll %LIBRARY_BIN%
popd
exit /b 0
