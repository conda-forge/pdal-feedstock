#!/bin/bash
set -ex

# temporary prefix to be able to install files more granularly


if [[ "${PKG_NAME}" == "libpdal" ]]; then

cmake --install ./build
# cp ./temp_prefix/lib/libpdalcpp.* $PREFIX/lib
# cp -R ./temp_prefix/include/pdal/. $PREFIX/include/pdal
# cp ./temp_prefix/lib/pkgconfig/pdal.pc $PREFIX/lib/pkgconfig
# cp -R ./temp_prefix/lib/cmake/PDAL/. $PREFIX/lib/cmake/PDAL
# cp ./temp_prefix/bin/pdal $PREFIX/bin
# Copy the [de]activate scripts to $PREFIX/etc/conda/[de]activate.d, see
# https://conda-forge.org/docs/maintainer/adding_pkgs.html#activate-scripts
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
elif [[ "${PKG_NAME}" == "libpdal-all" ]]; then
    # libarrow-all: install everything else (whatever ends up in this output
    # should generally be installed into the appropriate libarrow-<flavour>).
    cmake --install ./build --prefix=$PREFIX
else
echo "got unexpected package name: ${PKG_NAME}"
exit
fi

