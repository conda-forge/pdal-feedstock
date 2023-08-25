mkdir build
cd build

cmake -G "NMake Makefiles" ^
      -DCMAKE_INSTALL_PREFIX:PATH="%LIBRARY_PREFIX%" ^
      -DCMAKE_BUILD_TYPE:STRING=Release ^
      -DCMAKE_LIBRARY_PATH="%LIBRARY_LIB%" ^
      -DCMAKE_INCLUDE_PATH="%INCLUDE_INC%" ^
      -DBUILD_PLUGIN_E57=ON ^
      -DBUILD_PLUGIN_PGPOINTCLOUD=ON ^
      -DBUILD_PLUGIN_I3S=ON ^
      -DBUILD_PLUGIN_ICEBRIDGE=ON ^
      -DBUILD_PLUGIN_NITF=OFF ^
      -DBUILD_PLUGIN_TILEDB=OFF ^
      -DBUILD_PLUGIN_HDF=ON ^
      -DBUILD_PLUGIN_DRACO=ON ^
      -DENABLE_CTEST=OFF ^
      -DWITH_TESTS=OFF ^
      -DWITH_ZLIB=ON ^
      -DWITH_ZSTD=ON ^
      -DZSTD_LIBRARY="%LIBRARY_LIB%\libzstd.lib" ^
      %SRC_DIR%
if errorlevel 1 exit 1

nmake
if errorlevel 1 exit 1
