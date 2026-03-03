# SPDX-License-Identifier: GPL-2.0-only
#
# Copyright (C) 2021-2024 OpenWrt.org
# 物理修复版：专用于 SL3000 eMMC 1024M 编译
# 核心原则：物理锁死产物路径，强制对齐镜像 Makefile 的 cat 逻辑

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

# --- 物理定义 ---
define Package/uboot-mediatek
  SECTION:=boot
  CATEGORY:=Boot Loaders
  TITLE:=U-Boot for MediaTek devices
  DEPENDS:=@TARGET_mediatek
endef

# 物理逻辑：仅保留 SL3000 eMMC 目标
UBOOT_TARGETS := mt7981_sl_3000-emmc

# --- 核心对齐点：UBOOT_CONFIG 必须指向 configs/mt7981_emmc_defconfig ---
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

# 物理安装逻辑：强制重命名并分发到 STAGING_DIR_IMAGE 供镜像合成使用
define Package/uboot-mediatek/install
	mkdir -p $(STAGING_DIR_IMAGE)
	# 1. 物理重命名 BL2 (Preloader) 并推送到镜像目录
	$(CP) $(PKG_BUILD_DIR)/bl2.bin $(STAGING_DIR_IMAGE)/mt7981-emmc-ddr3-bl2.bin
	# 2. 物理重命名 FIP (U-Boot) 并推送到镜像目录
	$(CP) $(PKG_BUILD_DIR)/u-boot.fip $(STAGING_DIR_IMAGE)/mt7981-emmc-ddr3-u-boot.fip
	
	# 同时保留一份到常规安装目录供打包 (可选)
	$(CP) $(PKG_BUILD_DIR)/u-boot.bin $(1)/u-boot.bin
	$(CP) $(PKG_BUILD_DIR)/u-boot.fip $(1)/u-boot.fip
endef

$(eval $(call BuildPackage,uboot-mediatek))
