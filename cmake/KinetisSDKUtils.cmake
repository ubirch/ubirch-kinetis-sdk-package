macro(DetectKinetisSDK)
  set(args ${ARGN})
  if (ARGC GREATER 0)
    list(GET args 0 SDK_ROOT)
  endif ()
  if (ARGC GREATER 1)
    list(GET args 1 MCU)
  endif ()

  # set KSDK directory
  if (NOT SDK_ROOT)
    message(FATAL_ERROR "Kinetis SDK not found, use '-DSDK_ROOT=<sdk-dir>' to set root path!")
  endif ()

  get_filename_component(SDK_ROOT_ABSOLUTE "${SDK_ROOT}" REALPATH)
  set(KSDK_ROOT ${SDK_ROOT_ABSOLUTE})
  message(STATUS "Using Kinetis SDK: ${SDK_ROOT}")

  # identify MCU's available in selected SDK
  file(GLOB _MCU_LIST_DIR ${SDK_ROOT}/devices/*)
  foreach (_MCU_DIR ${_MCU_LIST_DIR})
    get_filename_component(_MCU ${_MCU_DIR} NAME)
    message(STATUS "Supported MCU: ${_MCU}")
    LIST(APPEND _MCU_LIST "${_MCU}")
  endforeach ()

  # check if the MCU the user selected is in the SDK
  list(FIND _MCU_LIST "${MCU}" MCU_FOUND)
  if (NOT MCU)
    if (MCU_NUMBER EQUAL 1)
      list(GET MCU_LIST 0 MCU)
    else ()
      message(FATAL_ERROR "Kinetis SDK contains more than one MCU, select one with -DSDK_MCU=<mcu>!")
    endif ()
  elseif (MCU_FOUND EQUAL -1)
    message(FATAL_ERROR "Kinetis SDK does not support selected MCU: ${MCU}")
  endif ()

  # set MCU for further usage
  message(STATUS "Selected MCU: ${MCU} (${MCU_FOUND})")
endmacro()

# configure special settings for the selected MCU
macro(ConfigureMCU MCU)
  get_filename_component(MCU_FLASH_LD "${KSDK_ROOT}/devices/${MCU}/gcc/MK82FN256xxx15_flash.ld" REALPATH)
  set(MCU_FLAGS -mcpu=cortex-m4 -mfloat-abi=hard -mfpu=fpv4-sp-d16)
  set(MCU_C_FLAGS -DCPU_MK82FN256VDC15 ${MCU_FLAGS})

  # The single quoted file name for the linker file does not work on Windows, but we need to escape spaces
  if (CMAKE_HOST_SYSTEM_NAME STREQUAL "Windows")
    set(MCU_LINKER_FLAGS ${MCU_FLAGS} -T\"${MCU_FLASH_LD}\")
  else()
    set(MCU_LINKER_FLAGS ${MCU_FLAGS} -T'${MCU_FLASH_LD}')
  endif()
  set(MCU_LINKER_FLAGS ${MCU_FLAGS} -static --specs=nano.specs -Wl,--gc-sections -Wl,-z,muldefs
          -Wl,--defsym=__stack_size__=0x2000 -Wl,--defsym=__heap_size__=0x2000
    )
endmacro()
