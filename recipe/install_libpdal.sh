#!/bin/bash
set -ex

# temporary prefix to be able to install files more granularly


if [[ "${PKG_NAME}" == "libpdal" ]]; then

    echo "abcdefghijklmnop"
    echo "im located at `pwd`"
    echo "im installing to $PREFIX"

#cmake --install ./build --prefix=$PREFIX
cp ./build/lib/libpdalcpp.* $PREFIX/lib
cp -R ./build/include/pdal/. $PREFIX/include/pdal
cp ./build/apps/pdal.pc $PREFIX/lib/pkgconfig
cp -R ./build/*.cmake $PREFIX/lib/cmake/PDAL
cp ./build/bin/pdal $PREFIX/bin

ls -al $PREFIX/lib/libpdalcpp*

## Copy the [de]activate scripts to $PREFIX/etc/conda/[de]activate.d, see
## https://conda-forge.org/docs/maintainer/adding_pkgs.html#activate-scripts
for CHANGE in "activate" "deactivate"
do
    mkdir -p "${PREFIX}/etc/conda/${CHANGE}.d"
    cp "${RECIPE_DIR}/scripts/${CHANGE}.sh" "${PREFIX}/etc/conda/${CHANGE}.d/${PKG_NAME}_${CHANGE}.sh"
done


elif [[ "${PKG_NAME}" == "libpdal-arrow" ]]; then
    cp ./plugins/arrow/build/libpdal_plugin*.* $PREFIX/lib
elif [[ "${PKG_NAME}" == "libpdal-hdf" ]]; then
    cp ./plugins/hdf/build/libpdal_plugin*.* $PREFIX/lib
    cp ./plugins/icebridge/build/libpdal_plugin*.* $PREFIX/lib
elif [[ "${PKG_NAME}" == "libpdal-draco" ]]; then
    cp ./plugins/draco/build/libpdal_plugin*.* $PREFIX/lib
elif [[ "${PKG_NAME}" == "libpdal-pgpointcloud" ]]; then
    cp ./plugins/pgpointcloud/build/libpdal_plugin*.* $PREFIX/lib
elif [[ "${PKG_NAME}" == "libpdal-nitf" ]]; then
    cp ./plugins/nitf/build/libpdal_plugin*.* $PREFIX/lib
elif [[ "${PKG_NAME}" == "libpdal-trajectory" ]]; then
    cp ./plugins/trajectory/build/libpdal_plugin*.* $PREFIX/lib
elif [[ "${PKG_NAME}" == "libpdal-tiledb" ]]; then
    cp ./plugins/tiledb/build/libpdal_plugin*.* $PREFIX/lib
elif [[ "${PKG_NAME}" == "libpdal-all" ]]; then
#    cmake --install ./build --prefix=$PREFIX
    echo "libpdal-all already installed"
else
echo "got unexpected package name: ${PKG_NAME}"
exit 1
fi

