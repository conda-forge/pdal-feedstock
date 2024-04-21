#!/bin/bash
set -ex

# temporary prefix to be able to install files more granularly

mkdir temp_prefix

install_plugin () {
    dir="$1"
    pushd "$dir"
    mkdir temp_prefix
    cmake --install ./build --prefix=./temp_prefix
    cp ./temp_prefix/lib/libpdal_plugin*.* $PREFIX/lib
    rm -rf temp_prefix
    popd
}

if [[ "${PKG_NAME}" == "libpdal" ]]; then


cmake --install ./build --prefix=./temp_prefix
cp ./temp_prefix/lib/libpdalcpp.* $PREFIX/lib
cp -R ./temp_prefix/include/pdal/. $PREFIX/include/pdal
cp ./temp_prefix/lib/pkgconfig/pdal.pc $PREFIX/lib/pkgconfig
mkdir $PREFIX/lib/cmake/PDAL
cp -R ./temp_prefix/lib/cmake/PDAL/. $PREFIX/lib/cmake/PDAL
cp ./temp_prefix/bin/pdal $PREFIX/bin


## Copy the [de]activate scripts to $PREFIX/etc/conda/[de]activate.d, see
## https://conda-forge.org/docs/maintainer/adding_pkgs.html#activate-scripts
for CHANGE in "activate" "deactivate"
do
    mkdir -p "${PREFIX}/etc/conda/${CHANGE}.d"
    cp "${RECIPE_DIR}/scripts/${CHANGE}.sh" "${PREFIX}/etc/conda/${CHANGE}.d/${PKG_NAME}_${CHANGE}.sh"
done


elif [[ "${PKG_NAME}" == "libpdal-arrow" ]]; then
    install_plugin "plugins/arrow"
elif [[ "${PKG_NAME}" == "libpdal-hdf" ]]; then
    install_plugin "plugins/hdf"
    install_plugin "plugins/icebridge"
elif [[ "${PKG_NAME}" == "libpdal-draco" ]]; then
    install_plugin "plugins/draco"
elif [[ "${PKG_NAME}" == "libpdal-pgpointcloud" ]]; then
    install_plugin "plugins/pgpointcloud"
elif [[ "${PKG_NAME}" == "libpdal-nitf" ]]; then
    install_plugin "plugins/nitf"
elif [[ "${PKG_NAME}" == "libpdal-trajectory" ]]; then
    install_plugin "plugins/trajectory"
elif [[ "${PKG_NAME}" == "libpdal-tiledb" ]]; then
    install_plugin "plugins/tiledb"
elif [[ "${PKG_NAME}" == "libpdal-all" ]]; then
    echo "libpdal-all already installed"
else
echo "got unexpected package name: ${PKG_NAME}"
exit 1
fi

# Clean up temp_prefix
rm -rf temp_prefix
