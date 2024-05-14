# SPDX-License-Identifier: Apache-2.0
#
# AOSPEXT project (https://github.com/GloDroid/aospext)
#
# Copyright (C) 2021 GlobalLogic Ukraine
# Copyright (C) 2021-2022 Roman Stratiienko (r.stratiienko@gmail.com)

ifneq ($(filter true, $(BOARD_BUILD_AOSPEXT_LIBCAMERA)),)

LOCAL_PATH := $(call my-dir)
include $(LOCAL_PATH)/aospext_cleanup.mk

AOSPEXT_PROJECT_NAME := LIBCAMERA
AOSPEXT_BUILD_SYSTEM := meson

LOCAL_SHARED_LIBRARIES := libc libexif libjpeg libdl libudev libevent libcrypto
AOSPEXT_GEN_PKGCONFIGS := libexif libjpeg dl libudev libevent_pthreads libcrypto

MESON_BUILD_ARGUMENTS := \
    -Dwerror=false \
    -Dandroid=enabled \
    -Dipas=$(subst $(space),$(comma),$(BOARD_LIBCAMERA_IPAS))                \
    -Dpipelines=$(subst $(space),$(comma),$(BOARD_LIBCAMERA_PIPELINES))      \
    -Dsysconfdir=/vendor/etc                                                 \
    -Dtest=false                                                             \
    -Dlc-compliance=enabled                                                 \
    -Dcam=enabled                                                            \
    $(BOARD_LIBCAMERA_EXTRA_MESON_ARGS)

# Format: TYPE:REL_PATH_TO_INSTALL_ARTIFACT:VENDOR_SUBDIR:MODULE_NAME:SYMLINK_SUFFIX
# TYPE one of: lib, bin, etc
AOSPEXT_GEN_TARGETS := \
    lib:libcamera.so::libcamera:              \
    lib:libcamera-base.so::libcamera-base:    \
    bin:cam::libcamera-cam:                   \
    $(BOARD_LIBCAMERA_EXTRA_TARGETS)

AOSPEXT_EXPORT_INSTALLED_INCLUDE_DIRS := vendor/include/libcamera

LOCAL_MULTILIB := first
include $(LOCAL_PATH)/aospext_cross_compile.mk
include $(LOCAL_PATH)/aospext_gen_targets.mk

#-------------------------------------------------------------------------------

endif # BOARD_BUILD_AOSPEXT_LIBCAMERA
