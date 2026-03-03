include $(TOPDIR)/rules.mk
include $(INCLUDE_DIR)/kernel.mk

PKG_NAME:=uboot-mediatek
PKG_VERSION:=2024.10
PKG_RELEASE:=1

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://github.com/ykm99999/66.git
PKG_SOURCE_VERSION:=sl3000-uboot-base
PKG_MIRROR_HASH:=skip

PKG_MAINTAINER:=Gemini_AI

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/u-boot.mk

define U-Boot/Default
  BUILD_TARGET:=mediatek
  BUILD_SUBTARGET:=mt7981
  BUILD_DEVICES:=sl_3000-emmc
endef

define U-Boot/mt7981_sl_3000-emmc
  NAME:=SL 3000 (eMMC)
  BUILD_DEVICES:=sl_3000-emmc
  UBOOT_CONFIG:=mt7981_sl_3000-emmc
  UBOOT_IMAGE:=u-boot.fip
  BL2_IMAGE:=bl2.bin
endef

UBOOT_TARGETS:=mt7981_sl_3000-emmc

define Package/uboot-mediatek/install
	mkdir -p $(STAGING_DIR_IMAGE)
	# 延续上一版物理修复：将 1024M 源码产出的 bl2/fip 强制对齐母版镜像宏路径
	$(CP) $(PKG_BUILD_DIR)/$(1)/bl2.bin $(STAGING_DIR_IMAGE)/mt7981-emmc-ddr3-bl2.bin
	$(CP) $(PKG_BUILD_DIR)/$(1)/u-boot.fip $(STAGING_DIR_IMAGE)/mt7981-emmc-ddr3-u-boot.fip
	
	# 物理备份至常规安装目录
	mkdir -p $(1)
	$(CP) $(PKG_BUILD_DIR)/$(1)/u-boot.bin $(1)/u-boot.bin 2>/dev/null || true
	$(CP) $(PKG_BUILD_DIR)/$(1)/u-boot.fip $(1)/u-boot.fip 2>/dev/null || true
endef

$(eval $(call BuildPackage,uboot-mediatek))
