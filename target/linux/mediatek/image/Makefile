# SPDX-License-Identifier: GPL-2.0-only
#
# Copyright (C) 2012-2015 OpenWrt.org
# Copyright (C) 2016-2017 LEDE project

include $(TOPDIR)/rules.mk
include $(INCLUDE_DIR)/image.mk

# --- 物理修复注入：定义缺失的 GPT 分区表构建宏 ---
define Build/mt798x-gpt
	$(STAGING_DIR_HOST)/bin/ptgen \
		-g -o $@.tmp \
		-a 1 -l 1024 \
		$(if $(findstring emmc,$1), -S 0x$(shell printf "%x" $(CONFIG_TARGET_EXT4_PARTSIZE_DEFAULT))) \
		-t 0xef -p 64M@0x20000 \
		-t 0x83 -p $(CONFIG_TARGET_EXT4_PARTSIZE_DEFAULT)M@0x4020000 \
		$(if $(findstring emmc,$1), -t 0x83 -p 100M@0x$(shell printf "%x" $(shell expr 64 + $(CONFIG_TARGET_EXT4_PARTSIZE_DEFAULT) + 4))) \
	&& mv $@.tmp $@
endef

define Build/sysupgrade-emmc
	rm -f $@.recovery
	mkfs.fat -C $@.recovery 3070

	./gen_$(SUBTARGET)_emmc_img.sh $@ \
		$(IMAGE_KERNEL) \
		$@.recovery \
		$(IMAGE_ROOTFS)
endef

# default all platform image(fit) build 
define Device/Default
  PROFILES = Default $$(DEVICE_NAME)
  KERNEL_NAME := Image
  KERNEL = kernel-bin | lzma | \
	fit lzma $$(KDIR)/image-$$(firstword $$(DEVICE_DTS)).dtb
  KERNEL_INITRAMFS = kernel-bin | lzma | \
	fit lzma $$(KDIR)/image-$$(firstword $$(DEVICE_DTS)).dtb
  FILESYSTEMS := squashfs
  DEVICE_DTS_DIR := $(DTS_DIR)
  IMAGES := sysupgrade.bin
  IMAGE/sysupgrade.bin := append-kernel | pad-to 128k | append-rootfs | \
	pad-rootfs | append-metadata
endef

include $(SUBTARGET).mk

define Image/Build
	$(call Image/Build/$(1),$(1))
endef

$(eval $(call BuildImage))
