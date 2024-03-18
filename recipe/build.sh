#!/bin/bash

set -ex

# strip std settings from conda
CXXFLAGS="${CXXFLAGS/-std=c++14/}"
CXXFLAGS="${CXXFLAGS/-std=c++11/}"
export CXXFLAGS

if [ "$(uname)" == "Linux" ]; then
   export LDFLAGS="${LDFLAGS} -Wl,-rpath-link,${PREFIX}/lib"

   # need this for draco finding
   export PKG_CONFIG_PATH="$PKG_CONFIG_PATH;${PREFIX}/lib64/pkgconfig"
fi


if [ "$CONDA_BUILD_CROSS_COMPILATION" == "1" ]; then
  mkdir native; cd native;

  # Unset them as we're ok with builds that are either slow or non-portable
  unset CFLAGS
  unset CXXFLAGS

  CC=$CC_FOR_BUILD CXX=$CXX_FOR_BUILD LDFLAGS=${LDFLAGS//$PREFIX/$BUILD_PREFIX} cmake -G "Unix Makefiles" \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_OSX_ARCHITECTURES="x86_64" \
    ..

  export DIMBUILDER=`pwd`/bin/dimbuilder
  make dimbuilder
  cd ..
else
  export DIMBUILDER=dimbuilder

fi

rm -rf build
mkdir -p build
pushd build

cmake -G Ninja \
  ${CMAKE_ARGS} \
  -DBUILD_SHARED_LIBS=ON \
  -DCMAKE_BUILD_TYPE=Release \
  -DCMAKE_INSTALL_PREFIX=$PREFIX \
  -DCMAKE_PREFIX_PATH=$PREFIX \
  -DDIMBUILDER_EXECUTABLE=$DIMBUILDER \
  -DBUILD_PLUGIN_I3S=ON \
  -DBUILD_PLUGIN_E57=ON \
  -DBUILD_PLUGIN_PGPOINTCLOUD=OFF \
  -DBUILD_PLUGIN_ARROW=OFF \
  -DENABLE_CTEST=OFF \
  -DWITH_TESTS=OFF \
  -DWITH_ZLIB=ON \
  -DWITH_ZSTD=ON \
  ..

cmake --build . --config Release
cmake --install . --config Release
    echo "i installed to $PREFIX"

popd


# Arrow
pushd plugins/arrow

rm -rf build
mkdir -p build
pushd build

cmake ${CMAKE_ARGS} \
  -DSTANDALONE=ON \
  -DCMAKE_BUILD_TYPE=Release \
  -DCMAKE_INSTALL_PREFIX=$PREFIX \
  -DCMAKE_PREFIX_PATH=$PREFIX \
  -DPDAL_DIR:PATH=$PREFIX \
  ..

cmake --build . --config Release --target pdal_plugin_writer_arrow pdal_plugin_reader_arrow
ls -al .

popd
popd

# Trajectory

pushd plugins/trajectory

rm -rf build
mkdir -p build
pushd build

cmake -G Ninja \
  ${CMAKE_ARGS} \
  -DSTANDALONE=ON \
  -DCMAKE_BUILD_TYPE=Release \
  -DCMAKE_INSTALL_PREFIX=$PREFIX \
  -DCMAKE_PREFIX_PATH=$PREFIX \
  -DBUILD_PLUGIN_TRAJECTORY=ON \
  -DPDAL_DIR:PATH=$PREFIX \
  ..

cmake --build . --config Release --target pdal_plugin_filter_trajectory

popd
popd

# TileDB

pushd plugins/tiledb

rm -rf build
mkdir -p build
pushd build

cmake -G Ninja ${CMAKE_ARGS} \
  -DSTANDALONE=ON \
  -DCMAKE_BUILD_TYPE=Release \
  -DCMAKE_INSTALL_PREFIX=$PREFIX \
  -DCMAKE_PREFIX_PATH=$PREFIX \
  -DBUILD_PLUGIN_TILEDB=ON \
  -DPDAL_DIR:PATH=$PREFIX \
  ..

cmake --build . --config Release --target pdal_plugin_reader_tiledb pdal_plugin_writer_tiledb

popd
popd


# pgpointcloud

pushd plugins/pgpointcloud

rm -rf build
mkdir -p build
pushd build

cmake -G Ninja ${CMAKE_ARGS} \
  -DSTANDALONE=ON \
  -DCMAKE_BUILD_TYPE=Release \
  -DCMAKE_INSTALL_PREFIX=$PREFIX \
  -DCMAKE_PREFIX_PATH=$PREFIX \
  -DPDAL_DIR:PATH=$PREFIX \
  -DBUILD_PLUGIN_PGPOINTCLOUD=ON \
  ..

cmake --build . --config Release --target pdal_plugin_reader_pgpointcloud

popd
popd

# NITF

pushd plugins/nitf

rm -rf build
mkdir -p build
pushd build

cmake -G Ninja ${CMAKE_ARGS} \
  -DSTANDALONE=ON \
  -DCMAKE_BUILD_TYPE=Release \
  -DCMAKE_INSTALL_PREFIX=$PREFIX \
  -DCMAKE_PREFIX_PATH=$PREFIX \
  -DBUILD_PLUGIN_NITF=ON \
  -DPDAL_DIR:PATH=$PREFIX \
  ..

cmake --build . --config Release --target pdal_plugin_reader_nitf

popd
popd

#HDF
pushd plugins/hdf

rm -rf build
mkdir -p build
pushd build


cmake -G Ninja ${CMAKE_ARGS} \
  -DCMAKE_BUILD_TYPE=Release \
  -DCMAKE_INSTALL_PREFIX=$PREFIX \
  -DCMAKE_PREFIX_PATH=$PREFIX \
  -DPDAL_DIR:PATH=$PREFIX \
  -DBUILD_PLUGIN_HDF=ON \
  -DSTANDALONE=ON \
  ..

cmake --build . --config Release --target pdal_plugin_reader_hdf

popd
popd


pushd plugins/icebridge

rm -rf build
mkdir -p build
pushd build

cmake -G Ninja ${CMAKE_ARGS} \
  -DCMAKE_BUILD_TYPE=Release \
  -DCMAKE_INSTALL_PREFIX=$PREFIX \
  -DCMAKE_PREFIX_PATH=$PREFIX \
  -DPDAL_DIR:PATH=$PREFIX \
  -DSTANDALONE=ON \
  -DBUILD_PLUGIN_ICEBRIDGE=ON \
  ..

cmake --build . --config Release --target pdal_plugin_reader_icebridge

popd
popd

# Draco

pushd plugins/draco

rm -rf build
mkdir -p build
pushd build

cmake -G Ninja ${CMAKE_ARGS} \
  -DSTANDALONE=ON \
  -DCMAKE_BUILD_TYPE=Release \
  -DCMAKE_INSTALL_PREFIX=$PREFIX \
  -DCMAKE_PREFIX_PATH=$PREFIX \
  -DBUILD_PLUGIN_DRACO=ON \
  -DPDAL_DIR:PATH=$PREFIX \
  ..

cmake --build . --config Release  --target pdal_plugin_writer_draco pdal_plugin_reader_draco

popd
popd


