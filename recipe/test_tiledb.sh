#!/bin/bash

# exit when any command fails
set -e
# print all commands
set -x

test -f ${PREFIX}/lib/libpdal_plugin_reader_tiledb${SHLIB_EXT}
test -f ${PREFIX}/lib/libpdal_plugin_writer_tiledb${SHLIB_EXT}
