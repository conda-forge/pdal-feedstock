
set CMAKE_GENERATOR=Ninja
%PYTHON% setup.py install -vv -- -DPython3_EXECUTABLE="%PYTHON%"



mkdir plugins
cd plugins
curl -OL https://files.pythonhosted.org/packages/18/6c/1077b11602cac1f11e0c80a7ca8008bf21b8d2b141c6022b56306ca407af/pdal-plugins-1.1.0.tar.gz
tar xvf pdal-plugins-1.1.0.tar.gz
cd pdal-plugins-1.1.0

%PYTHON% -m pip install . -v
cd ../..

set ACTIVATE_DIR=%PREFIX%\etc\conda\activate.d
set DEACTIVATE_DIR=%PREFIX%\etc\conda\deactivate.d
mkdir %ACTIVATE_DIR%
mkdir %DEACTIVATE_DIR%

copy %RECIPE_DIR%\scripts\activate.bat %ACTIVATE_DIR%\pdal-python-activate.bat
if errorlevel 1 exit 1

copy %RECIPE_DIR%\scripts\deactivate.bat %DEACTIVATE_DIR%\pdal-python-deactivate.bat
if errorlevel 1 exit 1

:: Copy unix shell activation scripts, needed by Windows Bash users
copy %RECIPE_DIR%\scripts\activate.sh %ACTIVATE_DIR%\pdal-python-activate.sh
if errorlevel 1 exit 1

copy %RECIPE_DIR%\scripts\deactivate.sh %DEACTIVATE_DIR%\pdal-python-deactivate.sh
if errorlevel 1 exit 1

