# SPDX-License-Identifier: GPL-2.0-only
#
# Copyright (C) 2012-2015 OpenWrt.org
# Copyright (C) 2016-2017 LEDE project

include $(TOPDIR)/rules.mk
include $(INCLUDE_DIR)/image.mk

# --- 物理修复注入：定义 eMMC 救砖全家桶构建宏 ---

# 1. 修复 GPT 分区表生成 (硬编码 512M Rootfs，彻底解决变量空值报错)
define Build/mt798x-gpt
	$(STAGING_DIR_HOST)/bin/ptgen \
		-g -o $@.tmp \
		-a 1 -l 1024 \
		-t 0xef -p 64M@0x20000 \
		-t 0x83 -p 512M@0x4020000 \
		-t 0x83 -p 100M@0x24020000 \
	&& mv $@.tmp $@
endef

# 2. 修复 Preloader (BL2) 提取逻辑 (解决 Missing Build/mt7981-bl2)
define Build/mt7981-bl2
	cat $(STAGING_DIR_IMAGE)/mt7981-$1-bl2.bin > $@
endef

# 3. 修复 U-Boot (FIP) 提取逻辑 (解决 Missing Build/mt7981-bl31-uboot)
define Build/mt7981-bl31-uboot
	cat $(STAGING_DIR_IMAGE)/mt7981-$1-u-boot.fip > $@
endef

# --- 原有逻辑保留 ---

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
