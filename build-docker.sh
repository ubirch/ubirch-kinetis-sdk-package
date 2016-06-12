#!/bin/bash -x

ARM_CONTAINER_VERSION="latest"



function init() {
  # this requires the Material for the pipeline to be named "ARM_BUILD_CONTAINER"
  DEPENDENCY_LABEL=`env | grep GO_DEPENDENCY_LABEL_ARM_BUILD_CONTAINER | cut -d= -f2 | sed 's/\s//g' | tr -d '\n'`

  if [ -z ${DEPENDENCY_LABEL} ]; then
    ARM_CONTAINER_VERSION="latest"
  else
    ARM_CONTAINER_VERSION="v${DEPENDENCY_LABEL}"
  fi


}

function build_software() {
  docker run --user `id -u`:`id -g` -e "HOME=/build" --workdir=/build/ubirch-kinetis-sdk-package --volume=${PWD}/..:/build --env=${SDK_ROOT}  --env=${TOOLCHAIN} --env=${MCU} --entrypoint=/bin/bash ubirch/arm-build:${ARM_CONTAINER_VERSION} ./build.sh
  if [ $? -ne 0 ]; then
      echo "Docker build failed"
      exit 1
  fi
}

case "$1" in
    build)
        init
        build_software
        ;;
    *)
        echo "Usage: $0 {build|publish}"
        exit 1
esac

exit 0
