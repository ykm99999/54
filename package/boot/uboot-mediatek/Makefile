include $(TOPDIR)/rules.mk
include $(INCLUDE_DIR)/kernel.mk

PKG_NAME:=uboot-mediatek
PKG_VERSION:=2024.10
PKG_RELEASE:=1

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://github.com/ykm888/66.git
PKG_SOURCE_VERSION:=sl3000-uboot-base
PKG_MIRROR_HASH:=skip

PKG_MAINTAINER:=Gemini_AI

include $(INCLUDE_DIR)/package.mk

define Package/uboot-mediatek
  SECTION:=boot
  CATEGORY:=Boot Loaders
  TITLE:=U-Boot for MediaTek MT7981 (SL 3000 eMMC)
  DEPENDS:=@TARGET_mediatek_mt7981
  URL:=https://github.com/ykm888/66.git
endef

# 准备阶段：执行默认操作后删除可能存在的 configure 文件
define Build/Prepare
	$(call Build/Prepare/Default)
	rm -f $(PKG_BUILD_DIR)/configure
endef

# 配置阶段：直接使用 defconfig
define Build/Configure
	$(MAKE) -C $(PKG_BUILD_DIR) mt7981_emmc_defconfig
endef

# 编译阶段：设置交叉编译工具链
define Build/Compile
	$(MAKE) -C $(PKG_BUILD_DIR) \
		CROSS_COMPILE=$(TARGET_CROSS) \
		all
endef

define Package/uboot-mediatek/install
	$(INSTALL_DIR) $(STAGING_DIR_IMAGE)
	$(CP) $(PKG_BUILD_DIR)/bl2.bin $(STAGING_DIR_IMAGE)/mt7981-emmc-ddr3-bl2.bin 2>/dev/null || true
	$(CP) $(PKG_BUILD_DIR)/u-boot.fip $(STAGING_DIR_IMAGE)/mt7981-emmc-ddr3-u-boot.fip 2>/dev/null || true
	$(INSTALL_DIR) $(1)/usr/share/uboot-mediatek
	$(CP) $(PKG_BUILD_DIR)/u-boot.bin $(1)/usr/share/uboot-mediatek/ 2>/dev/null || true
	$(CP) $(PKG_BUILD_DIR)/u-boot.fip $(1)/usr/share/uboot-mediatek/ 2>/dev/null || true
endef

$(eval $(call BuildPackage,uboot-mediatek))
