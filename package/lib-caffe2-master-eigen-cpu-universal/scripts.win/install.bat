@echo off

rem
rem Installation script for CK packages.
rem
rem See CK LICENSE.txt for licensing details.
rem See CK Copyright.txt for copyright details.
rem
rem Developer(s): Grigori Fursin, 2017
rem

rem PACKAGE_DIR
rem INSTALL_DIR

if "%CAFFE_BUILD_PYTHON%" == "ON" (
  echo.
  echo You are compiling Caffe2 with Python support!
  echo To use it you need to set up CK env as following ^(after installation^)^:
  echo.
  echo $ ck virtual env --tags=lib,caffe2
  echo $ ipython
  echo.
  set /p id="Press enter to continue"
)

cd /d %INSTALL_DIR%\src
mkdir build_host_protoc
cd /d %INSTALL_DIR%\src\build_host_protoc

echo **************************************************************
echo Configuring protobuf for Caffe 2 ...

cmake ..\third_party\protobuf\cmake ^
      -G"%CK_CMAKE_GENERATOR%" ^
      -DCMAKE_BUILD_TYPE:STRING=%CMAKE_CONFIG% ^
      -DCMAKE_INSTALL_PREFIX=. ^
      -Dprotobuf_BUILD_TESTS=OFF

if %errorlevel% neq 0 (
 echo.
 echo Error: protobuf configure failed ...
 goto err
)

echo **************************************************************
echo Building protobuf for Caffe2
cmake --build . --config %CMAKE_CONFIG% --target INSTALL 

if %errorlevel% neq 0 (
 echo.
 echo Error: protobuf build failed ...
 goto err
)

echo **************************************************************
echo Preparing vars for Caffe 2 ...

set CK_CXX_FLAGS_FOR_CMAKE=
set CK_CXX_FLAGS_ANDROID_TYPICAL=

set CK_CMAKE_EXTRA=%CK_CMAKE_EXTRA% ^
 -DCMAKE_BUILD_TYPE:STRING=%CMAKE_CONFIG% ^
 -DCMAKE_VERBOSE_MAKEFILE=1 ^
 -DBUILD_TEST=OFF ^
 -DUSE_THREADS=%USE_THREADS% ^
 -DUSE_NERVANA_GPU=%USE_NERVANA_GPU% ^
 -DUSE_GLOG=OFF ^
 -DUSE_GFLAGS=OFF ^
 -DUSE_LMDB=OFF ^
 -DUSE_LEVELDB=OFF ^
 -DUSE_LITE_PROTO=%USE_LITE_PROTO% ^
 -DUSE_NCCL=%USE_NCCL% ^
 -DUSE_NNPACK=%USE_NNPACK% ^
 -DUSE_OPENCV=OFF ^
 -DUSE_CUDA=%USE_CUDA% ^
 -DUSE_CNMEM=%USE_CNMEM% ^
 -DUSE_ZMQ=%USE_ZMQ% ^
 -DUSE_ROCKSDB=%USE_ROCKSDB% ^
 -DUSE_REDIS=%USE_REDIS% ^
 -DUSE_MPI=%USE_MPI% ^
 -DUSE_CUB=%USE_CUB% ^
 -DUSE_GLOO=%USE_GLOO% ^
 -DBUILD_SHARED_LIBS=OFF ^
 -DUSE_OPENMP=%USE_OPENMP% ^
 -DBUILD_PYTHON=%CAFFE_BUILD_PYTHON% ^
 -DBUILD_TEST=%BUILD_TEST%

rem -DBLAS=%WHICH_BLAS% ^
rem -DBUILD_BINARY=ON ^

exit /b 0

:err
exit /b 1
