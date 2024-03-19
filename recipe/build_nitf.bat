pushd plugins/nitf

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
      -DBUILD_PLUGIN_NITF=ON ^
      -DSTANDALONE=ON ^
      ..
if errorlevel 1 exit 1

cmake --build . --config Release --target pdal_plugin_reader_nitf
if %ERRORLEVEL% neq 0 exit 1

popd
popd
