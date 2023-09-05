cd plugins/hdf

mkdir build
cd build

cmake -G "NMake Makefiles" ^
      -DCMAKE_INSTALL_PREFIX:PATH="%LIBRARY_PREFIX%" ^
      -DCMAKE_BUILD_TYPE:STRING=Release ^
      -DCMAKE_LIBRARY_PATH="%LIBRARY_LIB%" ^
      -DCMAKE_INCLUDE_PATH="%INCLUDE_INC%" ^
      -DPDAL_DIR:PATH="%PREFIX%" ^
      -DBUILD_PLUGIN_HDF=ON ^
      -DSTANDALONE=ON ^
      %SRC_DIR%
if errorlevel 1 exit 1

nmake
if errorlevel 1 exit 1

nmake install
if errorlevel 1 exit 1

cd ../../plugins/icebridge

mkdir build
cd build

cmake -G "NMake Makefiles" ^
      -DCMAKE_INSTALL_PREFIX:PATH="%LIBRARY_PREFIX%" ^
      -DCMAKE_BUILD_TYPE:STRING=Release ^
      -DCMAKE_LIBRARY_PATH="%LIBRARY_LIB%" ^
      -DCMAKE_INCLUDE_PATH="%INCLUDE_INC%" ^
      -DPDAL_DIR:PATH="%PREFIX%" ^
      -DSTANDALONE=ON ^
      -DBUILD_PLUGIN_ICEBRIDGE=ON ^
      %SRC_DIR%
if errorlevel 1 exit 1

nmake
if errorlevel 1 exit 1

nmake install
if errorlevel 1 exit 1
