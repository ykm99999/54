# SPDX-License-Identifier: GPL-2.0-only
#
# Copyright (C) 2021-2024 OpenWrt.org
#
# 物理修复版：专用于 SL3000 eMMC 1024M 编译
# 核心原则：物理锁死单一设备，对齐真实文件名 mt7981_emmc_defconfig

include $(TOPDIR)/rules.mk
include $(INCLUDE_DIR)/kernel.mk

PKG_NAME:=uboot-mediatek
PKG_VERSION:=2024.10
PKG_RELEASE:=1

# 物理物理锁死：指向您的自定义 U-Boot 源码仓库及分支
PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://github.com/ykm99999/66.git
PKG_SOURCE_VERSION:=sl3000-uboot-base
PKG_MIRROR_HASH:=skip

PKG_MAINTAINER:=Daniel Golle <daniel@makrotopia.org>

PKG_BUILD_DEPENDS:=arm-trusted-firmware-tools/host

include $(INCLUDE_DIR)/package.mk

# --- 物理修复注入：定义 Package 基础信息 ---
define Package/uboot-mediatek
  SECTION:=boot
  CATEGORY:=Boot Loaders
  TITLE:=U-Boot for MediaTek devices
  DEPENDS:=@TARGET_mediatek
endef

# 物理逻辑：仅保留 SL3000 eMMC 目标
UBOOT_TARGETS := mt7981_sl_3000-emmc

# --- 核心对齐点：UBOOT_CONFIG 必须指向 configs/ 目录下的真实文件名 ---
define U-Boot/mt7981_sl_3000-emmc
  NAME:=SL3000 eMMC (1024M RAM)
  BUILD_DEVICES:=sl_3000-emmc
  UBOOT_CONFIG:=mt7981_emmc
  UBOOT_IMAGE:=u-boot.fip
  BL2_BOOTDEV:=emmc
  BL2_SOC:=mt7981
  BL2_DDRTYPE:=lpddr4
endef

UBOOT_CONFIGURE_VARS += BUILD_TARGET=$(1)

define Build/Configure
	$(call Build/Configure/U-Boot)
endef

define Build/Compile
	$(call Build/Compile/U-Boot)
endef

# 物理安装逻辑：产出 FIP 和 Preloader
define Package/uboot-mediatek/install
	$(CP) $(PKG_BUILD_DIR)/u-boot.bin $(1)/u-boot.bin
	$(if $(shell [ -f $(PKG_BUILD_DIR)/u-boot.fip ] && echo 1), \
		$(CP) $(PKG_BUILD_DIR)/u-boot.fip $(1)/u-boot.fip \
	)
endef

$(eval $(call BuildPackage,uboot-mediatek))
