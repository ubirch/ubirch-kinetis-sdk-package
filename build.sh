#! /bin/sh
TOOLCHAIN=../ubirch-arm-toolchain/cmake/ubirch-arm-gcc-toolchain.cmake
SDK_NAME=SDK_2.0_MK82FN256xxx15
MCU=MK82F25615
if [ "$1" == "-a" ]
then BUILDS="Debug Release MinSizeRel RelWithDebInfo"
else BUILDS=MinSizeRel
fi
# do an out-of-source build for all configurations
[ -d "build/$MCU" ] && rm -r "build/$MCU"
for BUILD_TYPE in $BUILDS
do
  (mkdir -p "build/$MCU/$BUILD_TYPE"; cd "build/$MCU/$BUILD_TYPE"; \
  cmake ../../.. -DCMAKE_TOOLCHAIN_FILE="../../../$TOOLCHAIN" \
    -DSDK_ROOT="../$SDK_NAME" \
    -DMCU="$MCU" \
    -DCMAKE_BUILD_TYPE="$BUILD_TYPE"; \
  make)
done
