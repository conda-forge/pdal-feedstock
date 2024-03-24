#!/bin/bash

# exit when any command fails
set -e
# print all commands
set -x

pdal --version 
pdal --drivers --debug