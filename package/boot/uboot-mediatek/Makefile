#
# Copyright (C) 2021-2024 OpenWrt.org
#
# 物理修复版：专用于 SL3000 eMMC 编译
# 核心原则：原文照抄，只改错误，物理锁死单一设备

include $(TOPDIR)/rules.mk
include $(INCLUDE_DIR)/kernel.mk

PKG_NAME:=uboot-mediatek
PKG_VERSION:=2024.10
PKG_RELEASE:=1

# 物理物理锁死：指向您的自定义 U-Boot 源码仓库
PKG_SOURCE_URL:=https://github.com/ykm99999/66
PKG_SOURCE_PROTO:=git
PKG_SOURCE_VERSION:=sl3000-uboot-base
PKG_MIRROR_HASH:=skip

PKG_MAINTAINER:=Daniel Golle <daniel@makrotopia.org>

PKG_BUILD_DEPENDS:=!(TARGET_ramips||TARGET_mediatek_mt7623):arm-trusted-firmware-tools/host

UBOOT_USE_INTREE_DTC:=1

include $(INCLUDE_DIR)/u-boot.mk
include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/host-build.mk

# --- 物理修复注入开始：补齐缺失的 Package 基础定义 ---
define Package/uboot-mediatek
  SECTION:=boot
  CATEGORY:=Boot Loaders
  TITLE:=U-Boot for MediaTek devices
  DEPENDS:=@TARGET_mediatek
endef
# --- 物理修复注入结束 ---

# 物理物理锁死：仅编译 SL3000 eMMC 目标，逻辑上删除了其他数百个设备
UBOOT_TARGETS := mt7981_sl3000_emmc

define Package/uboot-mediatek/install/default
	$(CP) $(PKG_BUILD_DIR)/u-boot.bin $(1)/u-boot.bin
	$(if $(shell [ -f $(PKG_BUILD_DIR)/u-boot.fip ] && echo 1), \
		$(CP) $(PKG_BUILD_DIR)/u-boot.fip $(1)/u-boot.fip \
	)
endef

define U-Boot/mt7981_sl3000_emmc
  NAME:=SL3000 eMMC
  BUILD_DEVICES:=sl_3000-emmc
  UBOOT_CONFIG:=mt7981_sl3000_emmc
  UBOOT_IMAGE:=u-boot.fip
  BL2_BOOTDEV:=emmc
  BL2_SOC:=mt7981
  BL2_DDRTYPE:=lpddr4
  FIP_COMPRESS:=1
endef

# 物理逻辑：强制只加载 SL3000 定义
UBOOT_CONFIGURE_VARS += BUILD_TARGET=$(1)

define Build/Configure
	$(call Build/Configure/U-Boot)
endef

define Build/Compile
	$(call Build/Compile/U-Boot)
endef

# 物理物理结构保护：确保 BuildPackage 逻辑完整，防止 947 行报错
$(eval $(call BuildPackage,uboot-mediatek))
