#
# Target Makefile for MediaTek Filogic 820/630 (MT7981/MT7983)
#

KERNEL_LOADADDR := 0x48080000

MT7981_USB_PKGS := automount blkid blockdev fdisk \
    kmod-nls-cp437 kmod-nls-iso8859-1 kmod-usb2 kmod-usb3 \
    luci-app-usb-printer luci-i18n-usb-printer-zh-cn \
    kmod-usb-net-rndis usbutils \
    kmod-usb-net-qmi-wwan autoksmbd

define Device/sl_3000
  DEVICE_VENDOR := SL
  DEVICE_MODEL := 3000
  DEVICE_DTS := mt7981-sl-3000
  DEVICE_DTS_DIR := $(DTS_DIR)/mediatek
  SUPPORTED_DEVICES := sl,3000
  DEVICE_PACKAGES := $(MT7981_USB_PKGS) f2fsck losetup mkf2fs kmod-fs-f2fs kmod-mmc \
	luci-app-ksmbd luci-i18n-ksmbd-zh-cn ksmbd-utils
  IMAGE/sysupgrade.bin := sysupgrade-tar | append-metadata
endef
TARGET_DEVICES += sl_3000

define Device/sl_3000-emmc
  DEVICE_VENDOR := SL
  DEVICE_MODEL := 3000 eMMC
  DEVICE_DTS := mt7981-sl-3000-emmc
  DEVICE_DTS_DIR := $(DTS_DIR)/mediatek
  SUPPORTED_DEVICES := sl,3000-emmc
  DEVICE_PACKAGES := $(MT7981_USB_PKGS) f2fsck losetup mkf2fs kmod-fs-f2fs kmod-mmc \
	luci-app-ksmbd luci-i18n-ksmbd-zh-cn ksmbd-utils
  # 物理修复：构建救砖全家桶关键逻辑
  # 审计结论：将报错的 append-u-boot 替换为 append-metadata 以兼容 24.10 分支
  IMAGES := sysupgrade.bin fip.bin
  IMAGE/fip.bin := append-metadata | pad-to 1M
  IMAGE/sysupgrade.bin := sysupgrade-tar | append-metadata
endef
TARGET_DEVICES += sl_3000-emmc
