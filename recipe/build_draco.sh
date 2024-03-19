#!/bin/bash

set -ex

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
  -DPDAL_DIR:PATH="$PREFIX" \
  ..

cmake --build . --config Release  --target pdal_plugin_writer_draco pdal_plugin_reader_draco

popd
popd

