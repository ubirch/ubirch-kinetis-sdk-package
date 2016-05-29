# Build the Kinetis SDK 2.x
cmake_minimum_required(VERSION 3.0.2)
include(cmake/KinetisSDKUtils.cmake)
include(cmake/KinetisSDK.cmake)
include(cmake/KinetisMiddleware.cmake)

project(kinetis-sdk C CXX ASM)

# detect Kinetis SDK and supported MCU
DetectKinetisSDK(${SDK_ROOT} ${MCU})
ConfigureMCU(${MCU})

AddKinetisSDK()
AddKinetisMiddlewareDMAManager()
AddKinetisMiddlewareFATFS()
AddKinetisMiddlewareMMCAU()
AddKinetisMiddlewareSDMMC()
AddKinetisMiddlewareUSB()

# provide the package to other projects
provide(PACKAGE KinetisSDK MCU ${MCU} VERSION 2.0 TARGETS ${KSDK_TARGETS})
