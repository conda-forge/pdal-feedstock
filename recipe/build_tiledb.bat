pushd plugins/tiledb

rm -rf build
mkdir -p build
pushd build

cmake -G "Ninja" ^
      -DCMAKE_INSTALL_PREFIX:PATH="%LIBRARY_PREFIX%" ^
      -DCMAKE_BUILD_TYPE:STRING=Release ^
      -DCMAKE_LIBRARY_PATH="%LIBRARY_LIB%" ^
      -DCMAKE_INCLUDE_PATH="%INCLUDE_INC%" ^
      -DPDAL_DIR:PATH="%LIBRARY_PREFIX%" ^
      -DWITH_TESTS=OFF ^
      -DSTANDALONE=ON ^
      ..
if errorlevel 1 exit 1

cmake --build . --config Release --target pdal_plugin_reader_tiledb --target pdal_plugin_writer_tiledb
if %ERRORLEVEL% neq 0 exit 1

popd
popd
