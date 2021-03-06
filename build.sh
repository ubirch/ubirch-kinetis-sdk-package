#!/bin/bash -x
TOOLCHAIN=${TOOLCHAIN:-"../ubirch-arm-toolchain/cmake/ubirch-arm-gcc-toolchain.cmake"}
SDK_NAME=${SDK_NAME:-"SDK_2.0_MK82FN256xxx15"}
SDK_ROOT=${SDK_ROOT:-"../ubirch-kinetis-sdk"}/$SDK_NAME
MCU=${MCU:-"MK82F25615"}
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
    -DSDK_ROOT=$SDK_ROOT \
    -DMCU="$MCU" \
    -DCMAKE_BUILD_TYPE="$BUILD_TYPE"; \
  make)
done
