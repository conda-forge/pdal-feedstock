#!/bin/bash
set -ex

if [ "$CONDA_BUILD_CROSS_COMPILATION" == "1" ]; then
if [ "$(uname)" == "Darwin" ]; then
if [ "$target_platform" = "osx-arm64" ]; then
  export CMAKE_OSX_ARCHITECTURES="$OSX_ARCH"
fi
fi
fi

PY_VERSION=$(${PYTHON} -c "import sys; print(f'{sys.version_info.major}.{sys.version_info.minor}')")

# scikit-build only passes PYTHON_EXECUTABLE and doesn't pass Python3_EXECUTABLE
export CMAKE_ARGS="${CMAKE_ARGS} -DPDAL_DIR=$PREFIX -LAH --debug-find -DPython3_NumPy_INCLUDE_DIR=$PREFIX/lib/python${PY_VERSION}/site-packages/numpy/core/include/"

${PYTHON} -m pip install pdal==${PDAL_PYTHON_BINDINGS_VERSION} -vv --no-deps --no-build-isolation  --upgrade

${PYTHON} -m pip install pdal-plugins==${PDAL_PYTHON_PLUGINS_VERSION}  -vv --no-deps --no-build-isolation  --upgrade


# Copy the [de]activate scripts to $PREFIX/etc/conda/[de]activate.d.
# This will allow them to be run on environment activation.
for CHANGE in "activate" "deactivate"
do
    mkdir -p "${PREFIX}/etc/conda/${CHANGE}.d"
    echo "reading data in ${RECIPE_DIR}"
    cp "${RECIPE_DIR}/scripts/${CHANGE}-${PKG_NAME}.sh" "${PREFIX}/etc/conda/${CHANGE}.d/${PKG_NAME}_${CHANGE}.sh"
done