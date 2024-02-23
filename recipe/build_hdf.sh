#!/bin/bash

set -ex


pushd plugins/hdf

rm -rf build
mkdir -p build
pushd build


cmake -G Ninja ${CMAKE_ARGS} \
  -DCMAKE_BUILD_TYPE=Release \
  -DCMAKE_INSTALL_PREFIX=$PREFIX \
  -DCMAKE_PREFIX_PATH=$PREFIX \
  -DPDAL_DIR:PATH="$PREFIX" \
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
  -DPDAL_DIR:PATH="$PREFIX" \
  -DSTANDALONE=ON \
  -DBUILD_PLUGIN_ICEBRIDGE=ON \
  ..

cmake --build . --config Release --target pdal_plugin_reader_icebridge

popd
popd
