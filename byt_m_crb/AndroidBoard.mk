LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)
LOCAL_MODULE := byt_m_rpt_btns.kl
LOCAL_MODULE_TAGS := optional
LOCAL_SRC_FILES := byt_m_rpt_btns.kl
LOCAL_MODULE_CLASS := SHARED_LIBRARIES
LOCAL_MODULE_PATH := $(TARGET_OUT_KEYLAYOUT)
include $(BUILD_PREBUILT)

include $(PLATFORM_PATH)/AndroidBoard.mk

flashfiles: liveimg provimg
# parameter-framework
include $(DEVICE_CONF_PATH)/parameter-framework/AndroidBoard.mk

liveimg:
	@rm -rf $(PUBLISH_PATH)/$(TARGET_PUBLISH_PATH)/uefi-images/$(TARGET_BUILD_VARIANT)
	@mkdir -p $(PUBLISH_PATH)/$(TARGET_PUBLISH_PATH)/uefi-images/$(TARGET_BUILD_VARIANT)
	@cp $(PRODUCT_OUT)/live.img $(PUBLISH_PATH)/$(TARGET_PUBLISH_PATH)/uefi-images/$(TARGET_BUILD_VARIANT)/
	@$(ACP) -rpf $(PRODUCT_OUT)/iago/images/*.img $(PUBLISH_PATH)/$(TARGET_PUBLISH_PATH)/uefi-images/$(TARGET_BUILD_VARIANT)/
