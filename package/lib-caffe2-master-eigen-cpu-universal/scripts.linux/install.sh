#! /bin/bash

#
# Installation script for Caffe.
#
# See CK LICENSE for licensing details.
# See CK COPYRIGHT for copyright details.
#
# Developer(s):
# - Grigori Fursin, 2017;
#

# PACKAGE_DIR
# INSTALL_DIR

echo "**************************************************************"
echo "Preparing vars for Caffe 2 ..."

# Get eigen
cd ${INSTALL_DIR}/src
git submodule update --init -- third_party/eigen
git submodule update --init -- third_party/protobuf

# Print about python
if [ "${CAFFE_BUILD_PYTHON}" == "ON" ] ; then
  git submodule update --init -- third_party/pybind11

  echo ""
  echo "You are compiling Caffe2 with Python support!"
  echo "To use it you need to set up CK env as following (after installation)":
  echo ""
  echo "$ ck virtual env --tags=lib,caffe2"
  echo "$ ipython"
  echo ""
  read -p "Press enter to continue"
fi

CK_OPENMP="-fopenmp"
if [ "${CK_HAS_OPENMP}" = "0"  ]; then
  CK_OPENMP=""
fi

OPENCV_DIR=${CK_ENV_LIB_OPENCV_JNI}
if [ "${OPENCV_DIR}" == "" ]; then
  OPENCV_DIR=${CK_ENV_LIB_OPENCV}/share/OpenCV
fi

# Check extra stuff
EXTRA_FLAGS=""

cd ${INSTALL_DIR}/obj

cmake -DCMAKE_BUILD_TYPE=${CK_ENV_CMAKE_BUILD_TYPE:-Release} \
      -DCMAKE_C_COMPILER="${CK_CC_PATH_FOR_CMAKE}" \
      -DCMAKE_C_FLAGS="${CK_CC_FLAGS_FOR_CMAKE} ${EXTRA_FLAGS}" \
      -DCMAKE_CXX_COMPILER="${CK_CXX_PATH_FOR_CMAKE}" \
      -DCMAKE_CXX_FLAGS="${CK_CXX_FLAGS_FOR_CMAKE} ${EXTRA_FLAGS} -I${CK_ENV_LIB_OPENCV_INCLUDE}" \
      -DCMAKE_AR="${CK_AR_PATH_FOR_CMAKE}" \
      -DCMAKE_LINKER="${CK_LD_PATH_FOR_CMAKE}" \
      -DCAFFE2_CPU_FLAGS="${CAFFE2_CPU_FLAGS}" \
      -DCAFFE2_GPU_FLAGS="${CAFFE2_GPU_FLAGS}" \
      -DBLAS=${WHICH_BLAS} \
      -DUSE_THREADS=${USE_THREADS} \
      -DUSE_NERVANA_GPU=${USE_NERVANA_GPU} \
      -DUSE_GLOG=${USE_GLOG} \
      -DUSE_GFLAGS=${USE_GFLAGS} \
      -DUSE_LMDB=${USE_LMDB} \
      -DUSE_LEVELDB=${USE_LEVELDB} \
      -DUSE_LITE_PROTO=${USE_LITE_PROTO} \
      -DUSE_NCCL=${USE_NCCL} \
      -DUSE_NNPACK=${USE_NNPACK} \
      -DUSE_OPENCV=${USE_OPENCV} \
      -DUSE_CUDA=${USE_CUDA} \
      -DUSE_CNMEM=${USE_CNMEM} \
      -DUSE_ZMQ=${USE_ZMQ} \
      -DUSE_ROCKSDB=${USE_ROCKSDB} \
      -DUSE_REDIS=${USE_REDIS} \
      -DUSE_MPI=${USE_MPI} \
      -DUSE_GLOO=${USE_GLOO} \
      -DBUILD_SHARED_LIBS=${BUILD_SHARED_LIBS} \
      -DUSE_OPENMP=${USE_OPENMP} \
      -DBUILD_PYTHON=${CAFFE_BUILD_PYTHON} \
      -DBUILD_BINARY=${BUILD_BINARY} \
      -DBUILD_TEST=${BUILD_TEST} \
      -DGFLAGS_INCLUDE_DIR="${CK_ENV_LIB_GFLAGS_INCLUDE}" \
      -DGLOG_INCLUDE_DIR="${CK_ENV_LIB_GLOG_INCLUDE}" \
      -DGFLAGS_LIBRARY="${CK_ENV_LIB_GFLAGS_LIB}/libgflags.so" \
      -DGLOG_LIBRARY="${CK_ENV_LIB_GLOG_LIB}/libglog.so" \
      -DLMDB_INCLUDE_DIR="${CK_ENV_LIB_LMDB_INCLUDE}" \
      -DLMDB_LIBRARIES="${CK_ENV_LIB_LMDB_LIB}/liblmdb.so" \
      -DOpenCV_DIR="${OPENCV_DIR}" \
      -DPROTOBUF_INCLUDE_DIR="${CK_ENV_LIB_PROTOBUF_HOST_INCLUDE}" \
      -DPROTOBUF_PROTOC_EXECUTABLE="${CK_ENV_LIB_PROTOBUF_HOST}/bin/protoc" \
      -DPROTOBUF_LIBRARY="${CK_ENV_LIB_PROTOBUF_HOST_LIB}/libprotobuf.a" \
      -DCMAKE_INSTALL_PREFIX="${INSTALL_DIR}/install" \
      -DCMAKE_VERBOSE_MAKEFILE=ON \
      ../src

if [ "${?}" != "0" ] ; then
  echo "Error: cmake failed!"
  exit 1
fi

#export CK_MAKE_EXTRA="VERBOSE=1"

export PACKAGE_BUILD_TYPE=skip

return 0
