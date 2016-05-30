# check for middlewares that may be useful

# DMA Manager middleware
macro(AddKinetisMiddlewareDMAManager)
  file(GLOB DMAMGR_MIDDLEWARE ${KSDK_ROOT}/middleware/dma_manager*)
  list(LENGTH DMAMGR_MIDDLEWARE HAS_DMAMGR_MIDDLEWARE)
  if (HAS_DMAMGR_MIDDLEWARE EQUAL 1)
    message(STATUS "SDK has DMA Manager support, adding library libdma_manager.a")
    set(TARGET_DMAMGR dma_manager)

    include_directories(${KSDK_ROOT}/middleware/dma_manager_2.0.0)
    add_library(${TARGET_DMAMGR} STATIC
      "${KSDK_ROOT}/middleware/dma_manager_2.0.0/fsl_dma_manager.c"
      )
    target_include_directories(${TARGET_DMAMGR} INTERFACE ${KSDK_ROOT}/middleware/dma_manager_2.0.0)
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
      "${KSDK_ROOT}/middleware/fatfs_0.11a/fsl_mmc_diskfsl_mmc_disk.c"
      #      "${KSDK_ROOT}/middleware/fatfs_0.11a/fsl_option/freertos_syscall.c"
      #      "${KSDK_ROOT}/middleware/fatfs_0.11a/fsl_option/ucosii_syscall.c"
      #      "${KSDK_ROOT}/middleware/fatfs_0.11a/fsl_option/ucosiii_syscall.c"
      "${KSDK_ROOT}/middleware/fatfs_0.11a/fsl_ram_disk/fsl_ram_disk.c"
      "${KSDK_ROOT}/middleware/fatfs_0.11a/fsl_sd_disk/fsl_sd_disk.c"
      "${KSDK_ROOT}/middleware/fatfs_0.11a/fsl_sdspi_disk/fsl_sdspi_disk.c"
      "${KSDK_ROOT}/middleware/fatfs_0.11a/fsl_usb_disk/fsl_usb_disk_bm.c"
      #      "${KSDK_ROOT}/middleware/fatfs_0.11a/fsl_usb_disk/fsl_usb_disk_freertos.c"
      "${KSDK_ROOT}/middleware/fatfs_0.11a/option/cc932.c"
      "${KSDK_ROOT}/middleware/fatfs_0.11a/option/cc936.c"
      "${KSDK_ROOT}/middleware/fatfs_0.11a/option/cc949.c"
      "${KSDK_ROOT}/middleware/fatfs_0.11a/option/cc950.c"
      "${KSDK_ROOT}/middleware/fatfs_0.11a/option/ccsbcs.c"
      "${KSDK_ROOT}/middleware/fatfs_0.11a/option/syscall.c"
      "${KSDK_ROOT}/middleware/fatfs_0.11a/option/unicode.c"
      )

    set(FATFS_MIDDLEWARE_INC
      "${KSDK_ROOT}/middleware/fatfs_0.11a/fsl_mmc_disk"
      "${KSDK_ROOT}/middleware/fatfs_0.11a/fsl_ram_disk"
      "${KSDK_ROOT}/middleware/fatfs_0.11a/fsl_sd_disk"
      "${KSDK_ROOT}/middleware/fatfs_0.11a/fsl_sdspi_disk"
      "${KSDK_ROOT}/middleware/fatfs_0.11a/fsl_usb_disk"
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

    include_directories(${KSDK_ROOT}/middleware/mmcau_2.0.0/asm-cm4-cm7/src)
    add_library(${TARGET_MMCAU} STATIC
      "${KSDK_ROOT}/middleware/mmcau_2.0.0/asm-cm4-cm7/src/cau2_defines.hdr"
      "${KSDK_ROOT}/middleware/mmcau_2.0.0/asm-cm4-cm7/src/mmcau_aes_functions.s"
      "${KSDK_ROOT}/middleware/mmcau_2.0.0/asm-cm4-cm7/src/mmcau_des_functions.s"
      "${KSDK_ROOT}/middleware/mmcau_2.0.0/asm-cm4-cm7/src/mmcau_md5_functions.s"
      "${KSDK_ROOT}/middleware/mmcau_2.0.0/asm-cm4-cm7/src/mmcau_sha1_functions.s"
      "${KSDK_ROOT}/middleware/mmcau_2.0.0/asm-cm4-cm7/src/mmcau_sha256_functions.s"
      )
    target_include_directories(${TARGET_MMCAU} INTERFACE ${KSDK_ROOT}/middleware/mmcau_2.0.0)
    target_compile_options(${TARGET_MMCAU} PRIVATE ${MCU_C_FLAGS})

    list(APPEND KSDK_TARGETS ${TARGET_MMCAU})
  endif ()
endmacro()

# SDMMC middleware
macro(AddKinetisMiddlewareSDMMC)
  file(GLOB SDMMC_MIDDLEWARE ${KSDK_ROOT}/middleware/sdmmc*)
  list(LENGTH SDMMC_MIDDLEWARE HAS_SDMMC_MIDDLEWARE)
  if (HAS_SDMMC_MIDDLEWARE EQUAL 1)
    message(STATUS "SDK has SD/MMC support, adding library libsdmmc.a")
    set(TARGET_SDMMC sdmmc)

    include_directories(${KSDK_ROOT}/middleware/sdmmc_2.0.0/inc)
    add_library(${TARGET_SDMMC} STATIC
      "${KSDK_ROOT}/middleware/sdmmc_2.0.0/src/fsl_mmc.c"
      "${KSDK_ROOT}/middleware/sdmmc_2.0.0/src/fsl_sd.c"
      "${KSDK_ROOT}/middleware/sdmmc_2.0.0/src/fsl_sdmmc.c"
      "${KSDK_ROOT}/middleware/sdmmc_2.0.0/src/fsl_sdspi.c"
      )
    target_include_directories(${TARGET_SDMMC} INTERFACE ${KSDK_ROOT}/middleware/sdmmc_2.0.0/inc)
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

    include_directories(${KSDK_ROOT}/middleware/usb_1.0.0/include)
    set(USB_MIDDLEWARE_SRCS
      "${KSDK_ROOT}/middleware/usb_1.0.0/device/usb_device_dci.c"
      "${KSDK_ROOT}/middleware/usb_1.0.0/device/usb_device_khci.c"
      "${KSDK_ROOT}/middleware/usb_1.0.0/osa/usb_osa_bm.c"
      #      "${KSDK_ROOT}/middleware/usb_1.0.0/osa/usb_osa_freertos.c"
      #      "${KSDK_ROOT}/middleware/usb_1.0.0/osa/usb_osa_ucosii.c"
      #      "${KSDK_ROOT}/middleware/usb_1.0.0/osa/usb_osa_ucosiii.c"
      )
    set(USB_HOST_MIDDLEWARE_SRCS
      "${KSDK_ROOT}/middleware/usb_1.0.0/host/class/usb_host_audio.c"
      "${KSDK_ROOT}/middleware/usb_1.0.0/host/class/usb_host_cdc.c"
      "${KSDK_ROOT}/middleware/usb_1.0.0/host/class/usb_host_hid.c"
      "${KSDK_ROOT}/middleware/usb_1.0.0/host/class/usb_host_hub.c"
      "${KSDK_ROOT}/middleware/usb_1.0.0/host/class/usb_host_hub_app.c"
      "${KSDK_ROOT}/middleware/usb_1.0.0/host/class/usb_host_msd.c"
      "${KSDK_ROOT}/middleware/usb_1.0.0/host/class/usb_host_msd_ufi.c"
      "${KSDK_ROOT}/middleware/usb_1.0.0/host/class/usb_host_phdc.c"
      "${KSDK_ROOT}/middleware/usb_1.0.0/host/usb_host_devices.c"
      "${KSDK_ROOT}/middleware/usb_1.0.0/host/usb_host_framework.c"
      "${KSDK_ROOT}/middleware/usb_1.0.0/host/usb_host_hci.c"
      "${KSDK_ROOT}/middleware/usb_1.0.0/host/usb_host_khci.c"
      )
    set(USB_MIDDLEWARE_INC
      ${KSDK_ROOT}/middleware/usb_1.0.0/include
      ${KSDK_ROOT}/middleware/usb_1.0.0/device
      ${KSDK_ROOT}/middleware/usb_1.0.0/osa)
    set(USB_MIDDLEWARE_INCL "set(USB_MIDDLEWARE_INC ${USB_MIDDLEWARE_INC} CACHE PATH \"\")")
    set(USB_MIDDLEWARE_SRCS "set(USB_MIDDLEWARE_SRCS ${USB_MIDDLEWARE_SRCS} CACHE PATH \"\")")
    set(USB_HOST_MIDDLEWARE_SRCS "set(USB_HOST_MIDDLEWARE_SRCS ${USB_HOST_MIDDLEWARE_SRCS} CACHE PATH \"\")")
  endif ()
endmacro()
