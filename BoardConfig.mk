
include device/intel/common/BoardConfig.mk

TARGET_ARCH_VARIANT := x86-slm

ifeq ($(FORCE_FLASHFILE_NO_OTA),true)
  FLASHFILE_NO_OTA := true
else
  FLASHFILE_NO_OTA := false
endif

BOARD_HAS_CAPSULE ?= true

HAS_SPINOR := true

# Disable recovery for now
TARGET_MAKE_NO_DEFAULT_RECOVERY := true
TARGET_NO_RECOVERY := false

BOARD_SKIP_NVM := false

ENABLE_GEN_GRAPHICS := true

# RenderScript Properties
# debug.rs.default-CPU-driver 1: force on CPU, 0 (default): use props as below:
#   rs.gpu.renderscript 0: run rs on CPU, 1: run rs on GPGPU
#   rs.gpu.filterscript 0: run fs on CPU, 1: run fs on GPGPU
#   rs.gpu.rsIntrinsic  0: run intrinsic on CPU, 1: on GPGPU
# These are the settings recommended by the RenderScript team:
ADDITIONAL_BUILD_PROPERTIES += rs.gpu.renderscript=1 \
                               rs.gpu.filterscript=1 \
                               rs.gpu.rsIntrinsic=1

ifneq ($(TARGET_NO_RECOVERY),true)
TARGET_RECOVERY_UI_LIB := libintel_recovery_ui
TARGET_RECOVERY_PIXEL_FORMAT := "BGRA_8888"
TARGET_RECOVERY_UPDATER_LIBS += libintel_updater
TARGET_RECOVERY_UPDATER_EXTRA_LIBS := libcmfwdl
endif

TARGET_USERIMAGES_SPARSE_EXT_DISABLED := false
ifeq ($(TARGET_USE_DROIDBOOT),true)
TARGET_DROIDBOOT_LIBS := libintel_droidboot
TARGET_DROIDBOOT_EXTRA_LIBS := libcmfwdl libminzip
TARGET_DROIDBOOT_USB_MODE_FASTBOOT := true
TARGET_MAKE_NO_DEFAULT_OTA_PACKAGE := true
TARGET_RELEASETOOLS_EXTENSIONS := $(HOST_OUT)/bin/releasetools.py
OTA_FROM_TARGET_FILES := $(HOST_OUT)/bin/ota_from_target_files
# Size in megabytes of Droidboot USB buffer, must be as large
# as the largest image we need to flash
DROIDBOOT_SCRATCH_SIZE := 100
DROIDBOOT_USE_INSTALLER := true
endif

ifeq ($(TARGET_DROIDBOOT_USB_MODE_FASTBOOT),true)
BOARD_KERNEL_DROIDBOOT_EXTRA_CMDLINE += g_android.fastboot=1 droidboot.minbatt=0
endif

ifneq ($(DROIDBOOT_SCRATCH_SIZE),)
BOARD_KERNEL_DROIDBOOT_EXTRA_CMDLINE += droidboot.scratch=$(DROIDBOOT_SCRATCH_SIZE)
endif

# enable libsensorhub
ENABLE_SENSOR_HUB := true

# enable scalable sensor HAL
ENABLE_SCALABLE_SENSOR_HAL := true

# Software MPEG4 encoder
SW_MPEG4_ENCODER := true

cmdline_extra += oops=panic panic=40

# Security
BUILD_WITH_SECURITY_FRAMEWORK := txei

INTEL_FEATURE_ARKHAM := true
ifeq ($(INTEL_FEATURE_ARKHAM),true)
PRODUCT_BOOT_JARS := $(PRODUCT_BOOT_JARS):com.intel.arkham.services
endif

BOARD_SEPOLICY_DIRS :=\
	device/intel/baytrail/sepolicy

BOARD_SEPOLICY_UNION :=\
	file_contexts \
	seapp_contexts \
	file.te \
	genfs_contexts \
	fs_use \
	device.te \
	healthd.te \
	app.te \
	untrusted_app.te \
	surfaceflinger.te \
	vold.te \
	ecryptfs.te \
	zygote.te \
	netd.te
