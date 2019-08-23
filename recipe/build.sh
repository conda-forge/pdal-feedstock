#!/bin/bash

set -ex

export CXXFLAGS="${CXXFLAGS} -std=c++11"
if [ "$(uname)" == "Linux" ]; then
   export LDFLAGS="${LDFLAGS} -Wl,-rpath-link,${PREFIX}/lib"
fi

which python

cmake -G "Unix Makefiles" \
  -DCMAKE_BUILD_TYPE=Release \
  -DCMAKE_INSTALL_PREFIX=$PREFIX \
  -DCMAKE_LIBRARY_PATH=$PREFIX/lib \
  -DCMAKE_INCLUDE_PATH=$PREFIX/include \
  -DBUILD_PLUGIN_I3S=ON \
  -DBUILD_PLUGIN_PYTHON=ON \
  -DPython3_EXECUTABLE:FILEPATH="$PREFIX/bin/python" \
  -DBUILD_PLUGIN_PGPOINTCLOUD=ON \
  -DBUILD_PLUGIN_SQLITE=ON \
  -DBUILD_PLUGIN_ICEBRIDGE=ON \
  -DBUILD_PLUGIN_NITF=ON \
  -DBUILD_PLUGIN_TILEDB=ON \
  -DENABLE_CTEST=OFF \
  -DWITH_TESTS=OFF \
  -DWITH_ZLIB=ON \
  -DWITH_ZSTD=ON \
  -DWITH_LAZPERF=ON \
  -DWITH_LASZIP=ON

# CircleCI offers two cores.
make -j $CPU_COUNT
make install

# This will not be needed once we fix upstream.
chmod 755 $PREFIX/bin/pdal-config

ACTIVATE_DIR=$PREFIX/etc/conda/activate.d
DEACTIVATE_DIR=$PREFIX/etc/conda/deactivate.d
mkdir -p $ACTIVATE_DIR
mkdir -p $DEACTIVATE_DIR

cp $RECIPE_DIR/scripts/activate.sh $ACTIVATE_DIR/pdal-activate.sh
cp $RECIPE_DIR/scripts/deactivate.sh $DEACTIVATE_DIR/pdal-deactivate.sh
