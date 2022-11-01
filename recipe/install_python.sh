#!/bin/bash

set -ex

# strip std settings from conda
CXXFLAGS="${CXXFLAGS/-std=c++14/}"
CXXFLAGS="${CXXFLAGS/-std=c++11/}"
export CXXFLAGS

if [ "$target_platform" = "osx-arm64" ]; then
  export CMAKE_OSX_ARCHITECTURES="arm64"
fi

# scikit-build only passes PYTHON_EXECUTABLE and doesn't pass Python3_EXECUTABLE
export CMAKE_ARGS="${CMAKE_ARGS} -DPython3_EXECUTABLE=$PREFIX/bin/python -DPython_EXECUTABLE=$PREFIX/bin/python -DPDAL_DIR=$PREFIX -LAH"

${PYTHON} -m pip install . -v

mkdir plugins && cd plugins
curl -OL https://files.pythonhosted.org/packages/66/e6/377c308a7f7d7f2a97008721e83061308a56e23f6be3b07989d44a4cfa9a/pdal-plugins-1.2.0.tar.gz
tar xvf pdal-plugins-1.2.0.tar.gz
cd pdal-plugins-1.2.0

#if [ "$CONDA_BUILD_CROSS_COMPILATION" == "1" ]; then
#rm $BUILD_PREFIX/lib/libpdal*
#rm $BUILD_PREFIX/lib/libpython*
#fi

${PYTHON} -m pip install . -vv
cd ../..

ACTIVATE_DIR=$PREFIX/etc/conda/activate.d
DEACTIVATE_DIR=$PREFIX/etc/conda/deactivate.d
mkdir -p $ACTIVATE_DIR
mkdir -p $DEACTIVATE_DIR

cp $RECIPE_DIR/scripts/activate.sh $ACTIVATE_DIR/pdal-python-activate.sh
cp $RECIPE_DIR/scripts/deactivate.sh $DEACTIVATE_DIR/pdal-python-deactivate.sh
