# Build the Kinetis SDK 2.x
set(KinetisSDK_VERSION 2.0)

cmake_minimum_required(VERSION 3.0.2)
include(cmake/KinetisSDKUtils.cmake)
include(cmake/KinetisSDK.cmake)
include(cmake/KinetisMiddleware.cmake)

enable_language(ASM)

# detect Kinetis SDK and supported MCU
DetectKinetisSDK(${SDK_ROOT} ${MCU})
ConfigureMCU(${MCU})

AddKinetisSDK()
AddKinetisMiddlewareMMCAU()

include(CMakePackageConfigHelpers)

# export the target ksdk20 from within the build tree, creating a config file
# for the MinSizeRel build type, also write a generic config file
if (CMAKE_BUILD_TYPE MATCHES MinSizeRel)
  export(TARGETS ${KSDK_TARGETS} FILE KinetisSDKConfig.cmake)
  write_basic_package_version_file(
    "${CMAKE_CURRENT_BINARY_DIR}/KinetisSDKConfigVersion.cmake"
    VERSION ${KinetisSDK_VERSION}
    COMPATIBILITY AnyNewerVersion
  )
endif ()

export(TARGETS ${KSDK_TARGETS} FILE KinetisSDK${CMAKE_BUILD_TYPE}Config.cmake)
write_basic_package_version_file(
  "${CMAKE_CURRENT_BINARY_DIR}/KinetisSDK${CMAKE_BUILD_TYPE}ConfigVersion.cmake"
  VERSION ${KinetisSDK_VERSION}
  COMPATIBILITY AnyNewerVersion
)

# register this target in the cmake registry
export(PACKAGE KinetisSDK)
