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
curl -OL https://files.pythonhosted.org/packages/a3/0a/65e7114cae766ffcfa94c31413197acd35213fd6a3461f656b8ff967a75a/pdal_plugins-1.5.0.tar.gz
tar xvf pdal_plugins-1.5.0.tar.gz
cd pdal_plugins-1.5.0

%PYTHON% -m pip install . -vv --no-deps --no-build-isolation
cd ../..