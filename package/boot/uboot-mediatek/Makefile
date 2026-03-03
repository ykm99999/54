define Package/uboot-mediatek/install
	mkdir -p $(STAGING_DIR_IMAGE)
	# 物理定位：从目标子目录中提取产物并强制改名对齐
	$(CP) $(PKG_BUILD_DIR)/$(1)/bl2.bin $(STAGING_DIR_IMAGE)/mt7981-emmc-ddr3-bl2.bin
	$(CP) $(PKG_BUILD_DIR)/$(1)/u-boot.fip $(STAGING_DIR_IMAGE)/mt7981-emmc-ddr3-u-boot.fip
	
	# 同时拷贝一份到常规安装包目录（可选）
	$(CP) $(PKG_BUILD_DIR)/$(1)/u-boot.bin $(1)/u-boot.bin 2>/dev/null || true
	$(CP) $(PKG_BUILD_DIR)/$(1)/u-boot.fip $(1)/u-boot.fip 2>/dev/null || true
endef
