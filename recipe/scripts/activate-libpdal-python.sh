#!/bin/bash

# Store existing PDAL env vars and set to this conda env
# so other PDAL installs don't pollute the environment

if [[ -n "$PDAL_DRIVER_PATH" ]]; then
    export _CONDA_SET_PDAL_PYTHON_DRIVER_PATH=$PDAL_DRIVER_PATH
fi

# if there's a BUILD_PREFIX we might be running under the host python
# and get an "Bad CPU type in executable"
if [ -z "$BUILD_PREFIX" ]; then
    PLUGIN_DIR_PATH=$(python -m pdal --pdal-plugin-path)
fi


if [[ ! -z "$PLUGIN_DIR_PATH" ]]; then
    export PDAL_DRIVER_PATH=$_CONDA_SET_PDAL_PYTHON_DRIVER_PATH:$PLUGIN_DIR_PATH
fi



