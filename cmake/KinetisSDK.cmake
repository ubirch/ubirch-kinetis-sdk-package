#
# Add Base Kinetis SDK files.
#
macro(AddKinetisSDK)
  set(TARGET_KSDK20 ksdk20)

  file(GLOB DRIVERS_SRCS "${KSDK_ROOT}/devices/${MCU}/drivers/*.c")
  add_library(${TARGET_KSDK20} STATIC
    ${DRIVERS_SRCS}
    "${KSDK_ROOT}/devices/${MCU}/gcc/startup_${MCU}.S"
    "${KSDK_ROOT}/devices/${MCU}/utilities/fsl_debug_console.c"
    "${KSDK_ROOT}/devices/${MCU}/utilities/fsl_notifier.c"
    "${KSDK_ROOT}/devices/${MCU}/utilities/fsl_sbrk.c"
    "${KSDK_ROOT}/devices/${MCU}/system_${MCU}.c"
    )

  # add special compiler and linker options required to link against selected MCU
  target_compile_options(${TARGET_KSDK20} PUBLIC ${MCU_C_FLAGS})
  target_link_libraries(${TARGET_KSDK20} PUBLIC ${MCU_LINKER_FLAGS})
  # export include directories
  target_include_directories(${TARGET_KSDK20} PUBLIC ${KSDK_ROOT}/CMSIS/Include)
  target_include_directories(${TARGET_KSDK20} PUBLIC ${KSDK_ROOT}/devices/${MCU}/drivers)
  target_include_directories(${TARGET_KSDK20} PUBLIC ${KSDK_ROOT}/devices/${MCU}/utilities)
  target_include_directories(${TARGET_KSDK20} PUBLIC ${KSDK_ROOT}/devices/${MCU})

  list(APPEND KSDK_TARGETS ${TARGET_KSDK20})
endmacro()
