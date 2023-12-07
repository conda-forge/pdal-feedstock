#!/bin/bash

set -ex


cd plugins/nitf

rm -rf build && mkdir build &&  cd build
cmake ${CMAKE_ARGS} \
  -DSTANDALONE=ON \
  -DCMAKE_BUILD_TYPE=Release \
  -DCMAKE_INSTALL_PREFIX=$PREFIX \
  -DCMAKE_PREFIX_PATH=$PREFIX \
  -DBUILD_PLUGIN_NITF=ON \
  -DPDAL_DIR:PATH="$PREFIX" \
  -DSTANDALONE=ON \
  ..

make -j $CPU_COUNT ${VERBOSE_CM}
make install
