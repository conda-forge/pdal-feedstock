#!/bin/bash

set -ex

export CXXFLAGS="${CXXFLAGS} -std=c++11"
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


fi


rm -rf build && mkdir build &&  cd build
cmake ${CMAKE_ARGS} \
  -DUILD_SHARED_LIBS=ON \
  -DCMAKE_BUILD_TYPE=Release \
  -DCMAKE_INSTALL_PREFIX=$PREFIX \
  -DDIMBUILDER_EXECUTABLE=$DIMBUILDER \
  -DBUILD_PLUGIN_I3S=ON \
  -DBUILD_PLUGIN_E57=ON \
  -DBUILD_PLUGIN_PGPOINTCLOUD=ON \
  -DBUILD_PLUGIN_ICEBRIDGE=ON \
  -DBUILD_PLUGIN_NITF=ON \
  -DBUILD_PLUGIN_TILEDB=ON \
  -DBUILD_PLUGIN_HDF=ON \
  -DBUILD_PLUGIN_DRACO=ON \
  -DENABLE_CTEST=OFF \
  -DWITH_TESTS=OFF \
  -DWITH_ZLIB=ON \
  -DWITH_ZSTD=ON \
  -DWITH_LASZIP=OFF \
  -DWITH_LAZPERF=ON \
  ..

make -j $CPU_COUNT ${VERBOSE_CM}
make install

# This will not be needed once we fix upstream.
chmod 755 $BUILD_PREFIX/bin/pdal-config

ACTIVATE_DIR=$BUILD_PREFIX/etc/conda/activate.d
DEACTIVATE_DIR=$BUILD_PREFIX/etc/conda/deactivate.d
mkdir -p $ACTIVATE_DIR
mkdir -p $DEACTIVATE_DIR

cp $RECIPE_DIR/scripts/activate.sh $ACTIVATE_DIR/pdal-activate.sh
cp $RECIPE_DIR/scripts/deactivate.sh $DEACTIVATE_DIR/pdal-deactivate.sh
