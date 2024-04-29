#!/bin/bash

# Store existing PDAL env vars and set to this conda env
# so other PDAL installs don't pollute the environment

if [[ -n "$PDAL_DRIVER_PATH" ]]; then
    export _CONDA_SET_PDAL_PYTHON_DRIVER_PATH=$PDAL_DRIVER_PATH
fi

PLUGIN_DIR_PATH=$(python -m pdal --pdal-plugin-path)

if [[ ! -z "$PLUGIN_DIR_PATH" ]]; then
    export PDAL_DRIVER_PATH=$_CONDA_SET_PDAL_PYTHON_DRIVER_PATH:$PLUGIN_DIR_PATH
fi



