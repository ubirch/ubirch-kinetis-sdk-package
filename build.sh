#! /bin/sh
TOOLCHAIN=../ubirch-arm-toolchain/cmake/ubirch-arm-gcc-toolchain.cmake
SDK_NAME=SDK_2.0_MK82FN256xxx15
MCU=MK82F25615
# do an out-of-source build for all configurations
[ -d build ] && rm -r build
for BUILD_TYPE in Debug Release MinSizeRel RelWithDebInfo
do
  (mkdir -p build/$BUILD_TYPE; cd build/$BUILD_TYPE; \
  cmake ../.. -DCMAKE_TOOLCHAIN_FILE="../../$TOOLCHAIN" \
    -DSDK_ROOT="../$SDK_NAME" \
    -DMCU="$MCU" \
    -DCMAKE_BUILD_TYPE="$BUILD_TYPE"; \
  make)
done
