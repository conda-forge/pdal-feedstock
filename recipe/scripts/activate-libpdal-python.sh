#!/bin/bash

# Store existing PDAL env vars and set to this conda env
# so other PDAL installs don't pollute the environment

if [[ -n "$PDAL_DRIVER_PATH" ]]; then
    export _CONDA_SET_PDAL_PYTHON_DRIVER_PATH=$PDAL_DRIVER_PATH
fi

env
# PLUGIN_DIR_PATH=$(python -m pdal --pdal-plugin-path)

# if [[ ! -z "$PLUGIN_DIR_PATH" ]]; then
#     export PDAL_DRIVER_PATH=$_CONDA_SET_PDAL_PYTHON_DRIVER_PATH:$PLUGIN_DIR_PATH
# fi

SITE_PACKAGES=$(python -c 'import site; print(site.getsitepackages()[0])')
SITE_PACKAGES_PDAL=$(python -c 'import site; import os.path; site_packages_pdal = os.path.join(site.getsitepackages()[0], "pdal"); print( site_packages_pdal if os.path.exists(site_packages_pdal) else "")')

if [[ ! -z "$SITE_PACKAGES_PDAL" ]]; then
    export PDAL_DRIVER_PATH=$_CONDA_SET_PDAL_PYTHON_DRIVER_PATH:$SITE_PACKAGES/lib:$SITE_PACKAGES/lib64:$SITE_PACKAGES_PDAL
else
    export PDAL_DRIVER_PATH=$_CONDA_SET_PDAL_PYTHON_DRIVER_PATH:$SITE_PACKAGES/lib:$SITE_PACKAGES/lib64
fi

