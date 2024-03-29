
echo ON

set PDAL_BUILD_DIR="%cd%/install"
mkdir %PDAL_BUILD_DIR%

mkdir build
pushd build

cmake -G "Ninja" ^
      %CMAKE_ARGS% ^
      -DCMAKE_INSTALL_PREFIX:PATH="%LIBRARY_PREFIX%" ^
      -DCMAKE_BUILD_TYPE:STRING=Release ^
      -DCMAKE_LIBRARY_PATH="%LIBRARY_LIB%" ^
      -DCMAKE_INCLUDE_PATH="%INCLUDE_INC%" ^
      -DBUILD_PLUGIN_E57=ON ^
      -DBUILD_PLUGIN_PGPOINTCLOUD=OFF ^
      -DBUILD_PLUGIN_ARROW=OFF ^
      -DBUILD_PLUGIN_DRACO=OFF ^
      -DENABLE_CTEST=OFF ^
      -DWITH_TESTS=OFF ^
      -DWITH_ZLIB=ON ^
      -DWITH_ZSTD=ON ^
      -DZSTD_LIBRARY="%LIBRARY_LIB%\libzstd.lib" ^
      ..
if errorlevel 1 exit 1

cmake --build . --config Release
cmake --install . --prefix=%PDAL_BUILD_DIR%
if %ERRORLEVEL% neq 0 exit 1

popd


REM ArrowV
pushd plugins\arrow

rmdir /s /q build
mkdir -p build
pushd build

cmake -G Ninja ^
  %CMAKE_ARGS% ^
  -DSTANDALONE=ON ^
  -DCMAKE_BUILD_TYPE=Release ^
  -DCMAKE_INSTALL_PREFIX=%PREFIX% ^
  -DCMAKE_PREFIX_PATH=%PREFIX% ^
  -DPDAL_DIR:PATH=%PDAL_BUILD_DIR%/lib/cmake/PDAL ^
  ..

cmake --build . --config Release --target libpdal_plugin_writer_arrow libpdal_plugin_reader_arrow

popd
popd

REM Trajectory 

pushd plugins\trajectory

rmdir /s /q build
mkdir -p build
pushd build

cmake -G Ninja ^
  %CMAKE_ARGS% ^
  -DSTANDALONE=ON ^
  -DCMAKE_BUILD_TYPE=Release ^
  -DCMAKE_INSTALL_PREFIX=%PREFIX% ^
  -DCMAKE_PREFIX_PATH=%PREFIX% ^
  -DPDAL_DIR:PATH=%PDAL_BUILD_DIR%/lib/cmake/PDAL ^
  ..

cmake --build . --config Release --target libpdal_plugin_filter_trajectory

popd
popd

REM TileDB

pushd plugins\tiledb

rmdir /s /q build
mkdir -p build
pushd build

cmake -G Ninja %CMAKE_ARGS% ^
  -DSTANDALONE=ON ^
  -DCMAKE_BUILD_TYPE=Release ^
  -DCMAKE_INSTALL_PREFIX=%PREFIX% ^
  -DCMAKE_PREFIX_PATH=%PREFIX% ^
  -DPDAL_DIR:PATH=%PDAL_BUILD_DIR%/lib/cmake/PDAL ^
  ..

cmake --build . --config Release --target libpdal_plugin_reader_tiledb libpdal_plugin_writer_tiledb

popd
popd


REM pgpointcloud

pushd plugins\pgpointcloud

rmdir /s /q build
mkdir -p build
pushd build

cmake -G Ninja %CMAKE_ARGS% ^
  -DSTANDALONE=ON ^
  -DCMAKE_BUILD_TYPE=Release ^
  -DCMAKE_INSTALL_PREFIX=%PREFIX% ^
  -DCMAKE_PREFIX_PATH=%PREFIX% ^
  -DPDAL_DIR:PATH=%PDAL_BUILD_DIR%/lib/cmake/PDAL ^
  ..

cmake --build . --config Release --target libpdal_plugin_reader_pgpointcloud libpdal_plugin_writer_pgpointcloud

popd
popd

REM NITF

pushd plugins\nitf

rmdir /s /q build
mkdir -p build
pushd build

cmake -G Ninja %CMAKE_ARGS% ^
  -DSTANDALONE=ON ^
  -DCMAKE_BUILD_TYPE=Release ^
  -DCMAKE_INSTALL_PREFIX=%PREFIX% ^
  -DCMAKE_PREFIX_PATH=%PREFIX% ^
  -DPDAL_DIR:PATH=%PDAL_BUILD_DIR%/lib/cmake/PDAL ^
  ..

cmake --build . --config Release --target libpdal_plugin_reader_nitf libpdal_plugin_writer_nitf

popd
popd

REM HDF
pushd plugins\hdf

rmdir /s /q build
mkdir -p build
pushd build


cmake -G Ninja %CMAKE_ARGS% ^
  -DCMAKE_BUILD_TYPE=Release ^
  -DCMAKE_INSTALL_PREFIX=%PREFIX% ^
  -DCMAKE_PREFIX_PATH=%PREFIX% ^
  -DPDAL_DIR:PATH=%PDAL_BUILD_DIR%/lib/cmake/PDAL ^
  -DSTANDALONE=ON ^
  ..

cmake --build . --config Release --target libpdal_plugin_reader_hdf

popd
popd


pushd plugins\icebridge

rmdir /s /q build
mkdir -p build
pushd build

cmake -G Ninja %CMAKE_ARGS% ^
  -DCMAKE_BUILD_TYPE=Release ^
  -DCMAKE_INSTALL_PREFIX=%PREFIX% ^
  -DCMAKE_PREFIX_PATH=%PREFIX% ^
  -DPDAL_DIR:PATH=%PDAL_BUILD_DIR%/lib/cmake/PDAL ^
  -DSTANDALONE=ON ^
  ..

cmake --build . --config Release --target libpdal_plugin_reader_icebridge

popd
popd

REM Draco

pushd plugins\draco

rmdir /s /q build
mkdir -p build
pushd build

cmake -G Ninja %CMAKE_ARGS% ^
  -DSTANDALONE=ON ^
  -DCMAKE_BUILD_TYPE=Release ^
  -DCMAKE_INSTALL_PREFIX=%PREFIX% ^
  -DCMAKE_PREFIX_PATH=%PREFIX% ^
  -DPDAL_DIR:PATH=%PDAL_BUILD_DIR%/lib/cmake/PDAL ^
  ..

cmake --build . --config Release  --target libpdal_plugin_writer_draco libpdal_plugin_reader_draco

popd
popd

