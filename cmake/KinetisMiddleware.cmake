# check for middlewares that may be useful

# MMCAU middleware
macro(AddKinetisMiddlewareMMCAU)
  file(GLOB MMCAU_MIDDLEWARE ${KSDK_ROOT}/middleware/mmcau*)
  list(LENGTH MMCAU_MIDDLEWARE HAS_MMCAU_MIDDLEWARE)
  if (HAS_MMCAU_MIDDLEWARE EQUAL 1)
    message(STATUS "MCU has MMCAU support, adding library libmmcau.a")
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
