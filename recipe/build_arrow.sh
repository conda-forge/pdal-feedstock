#!/bin/bash

set -ex

pushd plugins/arrow

rm -rf build
mkdir -p build
pushd build

cmake ${CMAKE_ARGS} \
  -DSTANDALONE=ON \
  -DCMAKE_BUILD_TYPE=Release \
  -DCMAKE_INSTALL_PREFIX=$PREFIX \
  -DCMAKE_PREFIX_PATH=$PREFIX \
  -DPDAL_DIR:PATH="$PREFIX" \
  ..

cmake --build . --config Release --target pdal_plugin_writer_arrow pdal_plugin_reader_arrow
ls -al .

popd
popd
