mkdir build
pushd build


set PDAL_BUILD_DIR="%cd%/install"
mkdir %PDAL_BUILD_DIR%

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


# ArrowV
pushd plugins\arrow

rm -rf build
mkdir -p build
pushd build

cmake -G Ninja \
  ${CMAKE_ARGS} %CMAKE_ARGS% ^
  -DSTANDALONE=ON ^
  -DCMAKE_BUILD_TYPE=Release ^
  -DCMAKE_INSTALL_PREFIX=%PREFIX% ^
  -DCMAKE_PREFIX_PATH=%PREFIX% ^
  -DPDAL_DIR:PATH=%PDAL_BUILD_DIR%/lib/cmake/PDAL ^
  ..

cmake --build . --config Release --target pdal_plugin_writer_arrow pdal_plugin_reader_arrow

popd
popd

# Trajectory

pushd plugins/trajectory

rm -rf build
mkdir -p build
pushd build

cmake -G Ninja %CMAKE_ARGS% ^
  -DSTANDALONE=ON ^
  -DCMAKE_BUILD_TYPE=Release ^
  -DCMAKE_INSTALL_PREFIX=%PREFIX% ^
  -DCMAKE_PREFIX_PATH=%PREFIX% ^
  -DBUILD_PLUGIN_TRAJECTORY=ON ^
  -DPDAL_DIR:PATH=%PDAL_BUILD_DIR%/lib/cmake/PDAL ^
  ..

cmake --build . --config Release --target pdal_plugin_filter_trajectory

popd
popd

# TileDB

pushd plugins/tiledb

rm -rf build
mkdir -p build
pushd build

cmake -G Ninja %CMAKE_ARGS% ^
  -DSTANDALONE=ON ^
  -DCMAKE_BUILD_TYPE=Release ^
  -DCMAKE_INSTALL_PREFIX=%PREFIX% ^
  -DCMAKE_PREFIX_PATH=%PREFIX% ^
  -DBUILD_PLUGIN_TILEDB=ON ^
  -DPDAL_DIR:PATH=%PDAL_BUILD_DIR%/lib/cmake/PDAL ^
  ..

cmake --build . --config Release --target pdal_plugin_reader_tiledb pdal_plugin_writer_tiledb

popd
popd


# pgpointcloud

pushd plugins/pgpointcloud

rm -rf build
mkdir -p build
pushd build

cmake -G Ninja %CMAKE_ARGS% ^
  -DSTANDALONE=ON ^
  -DCMAKE_BUILD_TYPE=Release ^
  -DCMAKE_INSTALL_PREFIX=%PREFIX% ^
  -DCMAKE_PREFIX_PATH=%PREFIX% ^
  -DPDAL_DIR:PATH=%PDAL_BUILD_DIR%/lib/cmake/PDAL ^
  -DBUILD_PLUGIN_PGPOINTCLOUD=ON ^
  ..

cmake --build . --config Release --target pdal_plugin_reader_pgpointcloud pdal_plugin_writer_pgpointcloud

popd
popd

# NITF

pushd plugins/nitf

rm -rf build
mkdir -p build
pushd build

cmake -G Ninja %CMAKE_ARGS% ^
  -DSTANDALONE=ON ^
  -DCMAKE_BUILD_TYPE=Release ^
  -DCMAKE_INSTALL_PREFIX=%PREFIX% ^
  -DCMAKE_PREFIX_PATH=%PREFIX% ^
  -DBUILD_PLUGIN_NITF=ON ^
  -DPDAL_DIR:PATH=%PDAL_BUILD_DIR%/lib/cmake/PDAL ^
  ..

cmake --build . --config Release --target pdal_plugin_reader_nitf pdal_plugin_writer_nitf

popd
popd

#HDF
pushd plugins/hdf

rm -rf build
mkdir -p build
pushd build


cmake -G Ninja %CMAKE_ARGS% ^
  -DCMAKE_BUILD_TYPE=Release ^
  -DCMAKE_INSTALL_PREFIX=%PREFIX% ^
  -DCMAKE_PREFIX_PATH=%PREFIX% ^
  -DPDAL_DIR:PATH=%PDAL_BUILD_DIR%/lib/cmake/PDAL ^
  -DBUILD_PLUGIN_HDF=ON ^
  -DSTANDALONE=ON ^
  ..

cmake --build . --config Release --target pdal_plugin_reader_hdf

popd
popd


pushd plugins/icebridge

rm -rf build
mkdir -p build
pushd build

cmake -G Ninja %CMAKE_ARGS% ^
  -DCMAKE_BUILD_TYPE=Release ^
  -DCMAKE_INSTALL_PREFIX=%PREFIX% ^
  -DCMAKE_PREFIX_PATH=%PREFIX% ^
  -DPDAL_DIR:PATH=%PDAL_BUILD_DIR%/lib/cmake/PDAL ^
  -DSTANDALONE=ON ^
  -DBUILD_PLUGIN_ICEBRIDGE=ON ^
  ..

cmake --build . --config Release --target pdal_plugin_reader_icebridge

popd
popd

# Draco

pushd plugins/draco

rm -rf build
mkdir -p build
pushd build

cmake -G Ninja %CMAKE_ARGS% ^
  -DSTANDALONE=ON ^
  -DCMAKE_BUILD_TYPE=Release ^
  -DCMAKE_INSTALL_PREFIX=%PREFIX% ^
  -DCMAKE_PREFIX_PATH=%PREFIX% ^
  -DBUILD_PLUGIN_DRACO=ON ^
  -DPDAL_DIR:PATH=%PDAL_BUILD_DIR%/lib/cmake/PDAL ^
  ..

cmake --build . --config Release  --target pdal_plugin_writer_draco pdal_plugin_reader_draco

popd
popd

