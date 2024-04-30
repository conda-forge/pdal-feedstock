@echo on
setlocal ENABLEDELAYEDEXPANSION

:: set UNIX_SP_DIR=%SP_DIR:\=/%
@REM set CMAKE_ARGS=%CMAKE_ARGS% -DPDAL_DIR=$PREFIX -LAH --debug-find -DPYTHON3_NUMPY_INCLUDE_DIRS=%UNIX_SP_DIR%/numpy/core/include


%PYTHON% -m pip install pdal==%PDAL_PYTHON_BINDINGS_VERSION% -vv --no-deps --no-build-isolation  --upgrade

%PYTHON% -m pip install pdal-plugins==%PDAL_PYTHON_PLUGINS_VERSION%  -vv --no-deps --no-build-isolation  --upgrade


set "ACTIVATE_DIR=%PREFIX%\etc\conda\activate.d"
set "DEACTIVATE_DIR=%PREFIX%\etc\conda\deactivate.d"

REM because we set ACTIVATE_DIR in this conditional, we have to
REM use the !
mkdir !ACTIVATE_DIR!
mkdir !DEACTIVATE_DIR!


:: Copy the [de]activate scripts to %PREFIX%\etc\conda\[de]activate.d.
:: This will allow them to be run on environment activation.
for %%F in (activate deactivate) DO (
    if not exist %PREFIX%\etc\conda\%%F.d mkdir %PREFIX%\etc\conda\%%F.d
    copy %RECIPE_DIR%\scripts\%%F-%PKG_NAME%.bat %PREFIX%\etc\conda\%%F.d\%PKG_NAME%_%%F.bat
    copy %RECIPE_DIR%\scripts\%%F-%PKG_NAME%.ps1 %PREFIX%\etc\conda\%%F.d\%PKG_NAME%_%%F.ps1
    :: Copy unix shell activation scripts, needed by Windows Bash users
    copy %RECIPE_DIR%\scripts\%%F-%PKG_NAME%.sh %PREFIX%\etc\conda\%%F.d\%PKG_NAME%_%%F.sh
)