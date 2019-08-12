#!/bin/bash

set -ex

export CXXFLAGS="${CXXFLAGS} -std=c++11"
if [ "$(uname)" == "Linux" ]; then
   export LDFLAGS="${LDFLAGS} -Wl,-rpath-link,${PREFIX}/lib"
fi

cmake -G "Unix Makefiles" \
  -D Python_ROOT_DIR:FILEPATH=${PREFIX} \
  -D Python_FIND_STRATEGY=LOCATION \
  -D CMAKE_BUILD_TYPE=Release \
  -D CMAKE_INSTALL_PREFIX=${PREFIX} \
  -D CMAKE_LIBRARY_PATH=${PREFIX}/lib \
  -D CMAKE_INCLUDE_PATH=${PREFIX}/include \
  -D BUILD_PLUGIN_GREYHOUND=ON \
  -D BUILD_PLUGIN_I3S=ON \
  -D BUILD_PLUGIN_PCL=ON \
  -D BUILD_PLUGIN_PYTHON=ON \
  -D PDAL_PYTHON_LIBRARY="libPython${SHLIB_EXT}" \
  -D BUILD_PLUGIN_PGPOINTCLOUD=ON \
  -D BUILD_PLUGIN_SQLITE=ON \
  -D BUILD_PLUGIN_ICEBRIDGE=ON \
  -D BUILD_PLUGIN_HEXBIN=ON \
  -D BUILD_PLUGIN_NITF=ON \
  -D BUILD_PLUGIN_TILEDB=ON \
  -D ENABLE_CTEST=OFF \
  -D WITH_TESTS=OFF \
  -D WITH_ZLIB=ON \
  -D WITH_ZSTD=ON \
  -D WITH_LAZPERF=ON \
  -D WITH_LASZIP=ON

# CircleCI offers two cores.
make -j $CPU_COUNT
make install

# This will not be needed once we fix upstream.
chmod 755 ${PREFIX}/bin/pdal-config

ACTIVATE_DIR=${PREFIX}/etc/conda/activate.d
DEACTIVATE_DIR=${PREFIX}/etc/conda/deactivate.d
mkdir -p $ACTIVATE_DIR
mkdir -p $DEACTIVATE_DIR

cp $RECIPE_DIR/scripts/activate.sh $ACTIVATE_DIR/pdal-activate.sh
cp $RECIPE_DIR/scripts/deactivate.sh $DEACTIVATE_DIR/pdal-deactivate.sh
