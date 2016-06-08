# check for middlewares that may be useful

# DMA Manager middleware
macro(AddKinetisMiddlewareDMAManager)
  file(GLOB DMAMGR_MIDDLEWARE ${KSDK_ROOT}/middleware/dma_manager*)
  list(LENGTH DMAMGR_MIDDLEWARE HAS_DMAMGR_MIDDLEWARE)
  if (HAS_DMAMGR_MIDDLEWARE EQUAL 1)
    message(STATUS "SDK has DMA Manager support, adding library libdma_manager.a")
    set(TARGET_DMAMGR dma_manager)

    include_directories(${DMAMGR_MIDDLEWARE})
    add_library(${TARGET_DMAMGR} STATIC
      "${DMAMGR_MIDDLEWARE}/fsl_dma_manager.c"
      )
    target_include_directories(${TARGET_DMAMGR} INTERFACE ${DMAMGR_MIDDLEWARE})
    target_link_libraries(${TARGET_DMAMGR} ksdk20)
    target_compile_options(${TARGET_DMAMGR} PRIVATE ${MCU_C_FLAGS})

    list(APPEND KSDK_TARGETS ${TARGET_DMAMGR})
  endif ()
endmacro()

# FATFS middleware
macro(AddKinetisMiddlewareFATFS)
  file(GLOB FATFS_MIDDLEWARE ${KSDK_ROOT}/middleware/fatfs*)
  list(LENGTH FATFS_MIDDLEWARE HAS_FATFS_MIDDLEWARE)
  if (HAS_FATFS_MIDDLEWARE EQUAL 1)
    message(STATUS "SDK has FATFS support, adding required sources to FATFS_MIDDLEWARE_SRCS/INC")

    set(FATFS_MIDDLEWARE_SRCS
      "${FATFS_MIDDLEWARE}/fsl_mmc_diskfsl_mmc_disk.c"
      #      "${FATFS_MIDDLEWARE}/fsl_option/freertos_syscall.c"
      #      "${FATFS_MIDDLEWARE}/fsl_option/ucosii_syscall.c"
      #      "${FATFS_MIDDLEWARE}/fsl_option/ucosiii_syscall.c"
      "${FATFS_MIDDLEWARE}/fsl_ram_disk/fsl_ram_disk.c"
      "${FATFS_MIDDLEWARE}/fsl_sd_disk/fsl_sd_disk.c"
      "${FATFS_MIDDLEWARE}/fsl_sdspi_disk/fsl_sdspi_disk.c"
      "${FATFS_MIDDLEWARE}/fsl_usb_disk/fsl_usb_disk_bm.c"
      #      "${FATFS_MIDDLEWARE}/fsl_usb_disk/fsl_usb_disk_freertos.c"
      "${FATFS_MIDDLEWARE}/option/cc932.c"
      "${FATFS_MIDDLEWARE}/option/cc936.c"
      "${FATFS_MIDDLEWARE}/option/cc949.c"
      "${FATFS_MIDDLEWARE}/option/cc950.c"
      "${FATFS_MIDDLEWARE}/option/ccsbcs.c"
      "${FATFS_MIDDLEWARE}/option/syscall.c"
      "${FATFS_MIDDLEWARE}/option/unicode.c"
      )

    set(FATFS_MIDDLEWARE_INC
      "${FATFS_MIDDLEWARE}/fsl_mmc_disk"
      "${FATFS_MIDDLEWARE}/fsl_ram_disk"
      "${FATFS_MIDDLEWARE}/fsl_sd_disk"
      "${FATFS_MIDDLEWARE}/fsl_sdspi_disk"
      "${FATFS_MIDDLEWARE}/fsl_usb_disk"
      )

    set(FATFS_MIDDLEWARE_INCL "set(FATFS_MIDDLEWARE_INC ${FATFS_MIDDLEWARE_INC} CACHE PATH \"\")")
    set(FATFS_MIDDLEWARE_SRCS "set(FATFS_MIDDLEWARE_SRCS ${FATFS_MIDDLEWARE_SRCS} CACHE PATH \"\")")
  endif ()
endmacro()

# MMCAU middleware
macro(AddKinetisMiddlewareMMCAU)
  file(GLOB MMCAU_MIDDLEWARE ${KSDK_ROOT}/middleware/mmcau*)
  list(LENGTH MMCAU_MIDDLEWARE HAS_MMCAU_MIDDLEWARE)
  if (HAS_MMCAU_MIDDLEWARE EQUAL 1)
    message(STATUS "SDK has MMCAU support, adding library libmmcau.a")
    set(TARGET_MMCAU mmcau)

    include_directories(${MMCAU_MIDDLEWARE}/asm-cm4-cm7/src)
    add_library(${TARGET_MMCAU} STATIC
      "${MMCAU_MIDDLEWARE}/asm-cm4-cm7/src/cau2_defines.hdr"
      "${MMCAU_MIDDLEWARE}/asm-cm4-cm7/src/mmcau_aes_functions.s"
      "${MMCAU_MIDDLEWARE}/asm-cm4-cm7/src/mmcau_des_functions.s"
      "${MMCAU_MIDDLEWARE}/asm-cm4-cm7/src/mmcau_md5_functions.s"
      "${MMCAU_MIDDLEWARE}/asm-cm4-cm7/src/mmcau_sha1_functions.s"
      "${MMCAU_MIDDLEWARE}/asm-cm4-cm7/src/mmcau_sha256_functions.s"
      )
    target_include_directories(${TARGET_MMCAU} INTERFACE ${MMCAU_MIDDLEWARE})
    target_compile_options(${TARGET_MMCAU} PRIVATE ${MCU_C_FLAGS})

    list(APPEND KSDK_TARGETS ${TARGET_MMCAU})
  endif ()
endmacro()

# SDMMC middleware
macro(AddKinetisMiddlewareSDMMC)
  find_file(HAS_SDHC NAMES ${KSDK_ROOT}/devices/${MCU}/drivers/fsl_sdhc.h)
  file(GLOB SDMMC_MIDDLEWARE ${KSDK_ROOT}/middleware/sdmmc*)
  list(LENGTH SDMMC_MIDDLEWARE HAS_SDMMC_MIDDLEWARE)
  if (HAS_SDHA AND HAS_SDMMC_MIDDLEWARE EQUAL 1)
    message(STATUS "SDK has SD/MMC support, adding library libsdmmc.a")
    set(TARGET_SDMMC sdmmc)

    include_directories(${SDMMC_MIDDLEWARE}/inc)
    add_library(${TARGET_SDMMC} STATIC
      "${SDMMC_MIDDLEWARE}/src/fsl_mmc.c"
      "${SDMMC_MIDDLEWARE}/src/fsl_sd.c"
      "${SDMMC_MIDDLEWARE}/src/fsl_sdmmc.c"
      "${SDMMC_MIDDLEWARE}/src/fsl_sdspi.c"
      )
    target_include_directories(${TARGET_SDMMC} INTERFACE ${SDMMC_MIDDLEWARE}/inc)
    target_link_libraries(${TARGET_SDMMC} ksdk20)
    target_compile_options(${TARGET_SDMMC} PRIVATE ${MCU_C_FLAGS})

    list(APPEND KSDK_TARGETS ${TARGET_SDMMC})
  endif ()
endmacro()

macro(AddKinetisMiddlewareUSB)
  file(GLOB USB_MIDDLEWARE ${KSDK_ROOT}/middleware/usb*)
  list(LENGTH USB_MIDDLEWARE HAS_USB_MIDDLEWARE)
  if (HAS_USB_MIDDLEWARE EQUAL 1)
    message(STATUS "SDK has USB support, adding required sources to USB_MIDDLEWARE_SRCS/INC + USB_HOST_MIDDLEWARE_SRCS")

    include_directories(${USB_MIDDLEWARE}/include)
    set(USB_MIDDLEWARE_SRCS
      "${USB_MIDDLEWARE}/device/usb_device_dci.c"
      "${USB_MIDDLEWARE}/device/usb_device_khci.c"
      "${USB_MIDDLEWARE}/osa/usb_osa_bm.c"
      #      "${USB_MIDDLEWARE}/osa/usb_osa_freertos.c"
      #      "${USB_MIDDLEWARE}/osa/usb_osa_ucosii.c"
      #      "${USB_MIDDLEWARE}/osa/usb_osa_ucosiii.c"
      )
    set(USB_HOST_MIDDLEWARE_SRCS
      "${USB_MIDDLEWARE}/host/class/usb_host_audio.c"
      "${USB_MIDDLEWARE}/host/class/usb_host_cdc.c"
      "${USB_MIDDLEWARE}/host/class/usb_host_hid.c"
      "${USB_MIDDLEWARE}/host/class/usb_host_hub.c"
      "${USB_MIDDLEWARE}/host/class/usb_host_hub_app.c"
      "${USB_MIDDLEWARE}/host/class/usb_host_msd.c"
      "${USB_MIDDLEWARE}/host/class/usb_host_msd_ufi.c"
      "${USB_MIDDLEWARE}/host/class/usb_host_phdc.c"
      "${USB_MIDDLEWARE}/host/usb_host_devices.c"
      "${USB_MIDDLEWARE}/host/usb_host_framework.c"
      "${USB_MIDDLEWARE}/host/usb_host_hci.c"
      "${USB_MIDDLEWARE}/host/usb_host_khci.c"
      )
    set(USB_MIDDLEWARE_INC
      ${USB_MIDDLEWARE}/include
      ${USB_MIDDLEWARE}/device
      ${USB_MIDDLEWARE}/osa)
    set(USB_MIDDLEWARE_INCL "set(USB_MIDDLEWARE_INC ${USB_MIDDLEWARE_INC} CACHE PATH \"\")")
    set(USB_MIDDLEWARE_SRCS "set(USB_MIDDLEWARE_SRCS ${USB_MIDDLEWARE_SRCS} CACHE PATH \"\")")
    set(USB_HOST_MIDDLEWARE_SRCS "set(USB_HOST_MIDDLEWARE_SRCS ${USB_HOST_MIDDLEWARE_SRCS} CACHE PATH \"\")")
  endif ()
endmacro()
