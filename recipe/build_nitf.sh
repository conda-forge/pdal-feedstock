#!/bin/bash

set -ex


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
  -DPDAL_DIR:PATH="$PREFIX" \
  ..

cmake --build . --config Release --target pdal_plugin_reader_nitf

popd
popd
