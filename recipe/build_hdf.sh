#!/bin/bash

set -ex


cd plugins/hdf

rm -rf build && mkdir build &&  cd build
cmake ${CMAKE_ARGS} \
  -DSTANDALONE=ON \
  -DCMAKE_BUILD_TYPE=Release \
  -DCMAKE_INSTALL_PREFIX=$PREFIX \
  -DCMAKE_PREFIX_PATH=$PREFIX \
  -DPDAL_DIR:PATH="$PREFIX" \
  -DBUILD_PLUGIN_HDF=ON \
  -DSTANDALONE=ON \
  ..

make -j $CPU_COUNT ${VERBOSE_CM}
make install


cd ../../icebridge

rm -rf build && mkdir build &&  cd build
cmake ${CMAKE_ARGS} \
  -DSTANDALONE=ON \
  -DCMAKE_BUILD_TYPE=Release \
  -DCMAKE_INSTALL_PREFIX=$PREFIX \
  -DCMAKE_PREFIX_PATH=$PREFIX \
  -DPDAL_DIR:PATH="$PREFIX" \
  -DSTANDALONE=ON \
  -DBUILD_PLUGIN_ICEBRIDGE=ON \
  ..

make -j $CPU_COUNT ${VERBOSE_CM}
make install
