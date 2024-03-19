pushd plugins/draco

rm -rf build
mkdir -p build
pushd build

cmake -G "Ninja" ^
      -DCMAKE_INSTALL_PREFIX:PATH="%LIBRARY_PREFIX%" ^
      -DCMAKE_BUILD_TYPE:STRING=Release ^
      -DCMAKE_LIBRARY_PATH="%LIBRARY_LIB%" ^
      -DCMAKE_INCLUDE_PATH="%INCLUDE_INC%" ^
      -DPDAL_DIR:PATH="%LIBRARY_PREFIX%" ^
      -DBUILD_PLUGIN_DRACO=ON ^
      -DSTANDALONE=ON ^
      -DWITH_TESTS=OFF ^
      ..
if errorlevel 1 exit 1

cmake --build . --config Release --target pdal_plugin_writer_draco pdal_plugin_reader_draco
if %ERRORLEVEL% neq 0 exit 1

popd
popd