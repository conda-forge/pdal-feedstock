#!/bin/bash
# Restore previous PDAL env vars if they were set

if [[ -n "$_CONDA_SET_PDAL_PYTHON_DRIVER_PATH" ]]; then
    export PDAL_DRIVER_PATH=$_CONDA_SET_PDAL_PYTHON_DRIVER_PATH
    unset _CONDA_SET_PDAL_PYTHON_DRIVER_PATH
fi

