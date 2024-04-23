#!/bin/bash
set -ex


git clone https://github.com/PDAL/python.git pdal-python
pushd pdal-python
git checkout pyproject


if [ "$CONDA_BUILD_CROSS_COMPILATION" == "1" ]; then

#    rm $BUILD_PREFIX/lib/libpdal*
#    rm $BUILD_PREFIX/lib/libpython*

if [ "$(uname)" == "Darwin" ]; then

if [ "$target_platform" = "osx-arm64" ]; then
  export CMAKE_OSX_ARCHITECTURES="$OSX_ARCH"
fi

fi

fi


${PYTHON} -m pip install . -vv --no-deps --no-build-isolation  --upgrade

mkdir plugins && pushd plugins
curl -OL https://files.pythonhosted.org/packages/52/f2/41ca8748c492dab89bea38d5b5b0c8dea5d9e9f41e4c81efbea4a1a56164/pdal_plugins-1.4.4.tar.gz
tar xvf pdal_plugins-1.4.4.tar.gz
cd pdal_plugins-1.4.4


${PYTHON} -m pip install .  -vv --no-deps --no-build-isolation  --upgrade
popd

popd