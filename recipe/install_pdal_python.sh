#!/bin/bash
set -ex


git clone https://github.com/PDAL/python.git pdal-python
pushd pdal-python


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
curl -OL https://files.pythonhosted.org/packages/a3/0a/65e7114cae766ffcfa94c31413197acd35213fd6a3461f656b8ff967a75a/pdal_plugins-1.5.0.tar.gz
tar xvf pdal_plugins-1.5.0.tar.gz
cd pdal_plugins-1.5.0


${PYTHON} -m pip install .  -vv --no-deps --no-build-isolation  --upgrade
popd

popd
