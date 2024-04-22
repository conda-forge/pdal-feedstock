@echo on
setlocal ENABLEDELAYEDEXPANSION


set CMAKE_GENERATOR=Ninja


:: %PYTHON% setup.py install -vv -- -DPython3_EXECUTABLE="%PYTHON%"
:: scikit-build only passes PYTHON_EXECUTABLE and doesn't pass Python3_EXECUTABLE
:: set UNIX_SP_DIR=%SP_DIR:\=/%
:: set CMAKE_ARGS=%CMAKE_ARGS% -DPDAL_DIR=$PREFIX -LAH --debug-find -DPYTHON3_NUMPY_INCLUDE_DIRS=%UNIX_SP_DIR%/numpy/core/include

%PYTHON% -m pip install . -vv --no-deps --no-build-isolation

mkdir plugins
cd plugins
curl -OL https://files.pythonhosted.org/packages/52/f2/41ca8748c492dab89bea38d5b5b0c8dea5d9e9f41e4c81efbea4a1a56164/pdal_plugins-1.4.4.tar.gz
tar xvf pdal_plugins-1.4.4.tar.gz
cd pdal_plugins-1.4.4

%PYTHON% -m pip install . -vv --no-deps --no-build-isolation
cd ../..