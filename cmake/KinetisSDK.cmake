#
# Add Base Kinetis SDK files.
#
macro(AddKinetisSDK)
  set(TARGET_KSDK2 ksdk2)

  file(GLOB DRIVERS_SRCS "${KSDK_ROOT}/devices/${MCU}/drivers/*.c")
  # remove FreeRTOS drivers
  list(REMOVE_ITEM DRIVERS_SRCS
    "${KSDK_ROOT}/devices/${MCU}/drivers/fsl_dspi_freertos.c"
    "${KSDK_ROOT}/devices/${MCU}/drivers/fsl_i2c_freertos.c"
    "${KSDK_ROOT}/devices/${MCU}/drivers/fsl_lpuart_freertos.c"
    "${KSDK_ROOT}/devices/${MCU}/drivers/fsl_smartcard_freertos.c"
    )

  add_library(${TARGET_KSDK2} STATIC
    ${DRIVERS_SRCS}
    "${KSDK_ROOT}/devices/${MCU}/gcc/startup_${MCU}.S"
    "${KSDK_ROOT}/devices/${MCU}/utilities/fsl_debug_console.c"
    "${KSDK_ROOT}/devices/${MCU}/utilities/fsl_notifier.c"
    "${KSDK_ROOT}/devices/${MCU}/utilities/fsl_sbrk.c"
    "${KSDK_ROOT}/devices/${MCU}/utilities/fsl_shell.c"
    "${KSDK_ROOT}/devices/${MCU}/system_${MCU}.c"
    )

  # add special compiler and linker options required to link against selected MCU
  target_compile_options(${TARGET_KSDK2} PUBLIC ${MCU_C_FLAGS})
  target_link_libraries(${TARGET_KSDK2} PUBLIC ${MCU_LINKER_FLAGS})
  # export include directories
  target_include_directories(${TARGET_KSDK2} PUBLIC ${KSDK_ROOT}/CMSIS/Include)
  target_include_directories(${TARGET_KSDK2} PUBLIC ${KSDK_ROOT}/devices/${MCU}/drivers)
  target_include_directories(${TARGET_KSDK2} PUBLIC ${KSDK_ROOT}/devices/${MCU}/utilities)
  target_include_directories(${TARGET_KSDK2} PUBLIC ${KSDK_ROOT}/devices/${MCU})

  list(APPEND KSDK_TARGETS ${TARGET_KSDK2})
endmacro()
