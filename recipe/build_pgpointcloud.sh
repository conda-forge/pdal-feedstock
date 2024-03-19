#!/bin/bash

set -ex


pushd plugins/pgpointcloud

rm -rf build
mkdir -p build
pushd build

cmake -G Ninja ${CMAKE_ARGS} \
  -DSTANDALONE=ON \
  -DCMAKE_BUILD_TYPE=Release \
  -DCMAKE_INSTALL_PREFIX=$PREFIX \
  -DCMAKE_PREFIX_PATH=$PREFIX \
  -DPDAL_DIR:PATH="$PREFIX" \
  -DBUILD_PLUGIN_PGPOINTCLOUD=ON \
  ..

cmake --build . --config Release --target pdal_plugin_reader_pgpointcloud

popd
popd