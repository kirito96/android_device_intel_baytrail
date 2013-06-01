### TEMPORARY: override flashfiles defined in common until baytrail supports them
### TEMPORARY: to be removed once BZ 105857 implemented

flashfiles: $(PRODUCT_OUT)/partition.tbl
	@$(eval FLASHFILE_PATH := $(PUBLISH_PATH)/$(TARGET_PUBLISH_PATH)/flash_files/build-$(PUBLISH_TARGET_BUILD_VARIANT))
	@$(eval FLASHFILE_NAME := $(GENERIC_TARGET_NAME)-$(PUBLISH_TARGET_BUILD_VARIANT)-fastboot-$(FILE_NAME_TAG).zip)
	@echo "Generating $(FLASHFILE_PATH)/$(FLASHFILE_NAME)"
	@mkdir -p $(FLASHFILE_PATH)
	@rm -rf $(FLASHFILE_PATH)/*
	@cp $(PRODUCT_OUT)/kernel $(FLASHFILE_PATH)/mos_kernel.efi
	@cp $(PRODUCT_OUT)/ramdisk.img $(FLASHFILE_PATH)/mos_ramdisk.img
	@cp $(PRODUCT_OUT)/boot.bin $(FLASHFILE_PATH)/
	@cp $(PRODUCT_OUT)/droidboot.img $(FLASHFILE_PATH)/
	@cp $(PRODUCT_OUT)/recovery.img $(FLASHFILE_PATH)/
	@cp $(INSTALLED_SYSTEMIMG_GZ_TARGET) $(FLASHFILE_PATH)/
	@cp $(TARGET_DEVICE_DIR)/flash.xml $(FLASHFILE_PATH)/
	@cp $(TARGET_DEVICE_DIR)/flash_capsule.xml $(FLASHFILE_PATH)/
	@cp $(OUT)/partition.tbl $(FLASHFILE_PATH)/
	# disabled as PLATFORM_PATH is overwritten by GPS makefile
	# @cp $(PLATFORM_PATH)/installer.cmd $(FLASHFILE_PATH)/
	@cp $(TARGET_DEVICE_DIR)/../installer.cmd $(FLASHFILE_PATH)/
	@cp $(IFWI_PREBUILT_PATHS)/dediprog.bin $(FLASHFILE_PATH)/
	@cp $(IFWI_PREBUILT_PATHS)/capsule.bin $(PRODUCT_OUT)/byt_psi_encapsulated_ifwi.bin
	@cp $(PRODUCT_OUT)/byt_psi_encapsulated_ifwi.bin $(FLASHFILE_PATH)/
	@zip -j $(FLASHFILE_PATH)/$(FLASHFILE_NAME) $(FLASHFILE_PATH)/*
	@find $(FLASHFILE_PATH) -name '*.zip' -prune -o -type f -exec rm {} \;
	# copy OTA file
	@$(eval FLASHFILE_NAME := $(GENERIC_TARGET_NAME)-ota-$(FILE_NAME_TAG).zip)
	@echo "Copying $(FLASHFILE_NAME)"
	@cp $(PRODUCT_OUT)/$(FLASHFILE_NAME) $(FLASHFILE_PATH)/
	# copy OTA input file
	@$(eval FLASHFILE_NAME := $(GENERIC_TARGET_NAME)-target_files-$(FILE_NAME_TAG).zip)
	@$(eval FLASHFILE_PATH := $(PUBLISH_PATH)/$(TARGET_PUBLISH_PATH)/ota_inputs/$(PUBLISH_TARGET_BUILD_VARIANT))
	@mkdir -p $(FLASHFILE_PATH)
	@echo "Copying $(FLASHFILE_NAME)"
	@cp $(PRODUCT_OUT)/obj/PACKAGING/target_files_intermediates/$(FLASHFILE_NAME) $(FLASHFILE_PATH)/

blank_flashfiles:
	@echo "No $@"
