#!/bin/bash

# Store existing PDAL env vars and set to this conda env
# so other PDAL installs don't pollute the environment

if [[ -n "$PDAL_DRIVER_PATH" ]]; then
    export _CONDA_SET_PDAL_DRIVER_PATH=$PDAL_DRIVER_PATH
fi

if [ -d $CONDA_PREFIX/share/gdal ]; then
    export PDAL_DRIVER_PATH=$CONDA_PREFIX/lib
elif [ -d $CONDA_PREFIX/Library/share/gdal ]; then
    export PDAL_DRIVER_PATH=$CONDA_PREFIX/Library/lib
fi

# Support plugins if the plugin directory exists
# i.e if it has been manually created by the user
if [[ ! -d "$PDAL_DRIVER_PATH" ]]; then
    unset PDAL_DRIVER_PATH
fi

