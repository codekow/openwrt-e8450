# Notes about E8450 UBI

```sh
# make scratch area
mkdir scratch
cd scratch

# download files
wget -N "https://github.com/dangowrt/owrt-ubi-installer/releases/download/v1.1.4/openwrt-24.10.0-mediatek-mt7622-linksys_e8450-ubi-initramfs-recovery-installer.itb"
wget -N "https://github.com/dangowrt/owrt-ubi-installer/releases/download/v1.1.4/openwrt-24.10.0-mediatek-mt7622-linksys_e8450-ubi-initramfs-recovery-installer_signed.itb"
wget -N "https://github.com/dangowrt/owrt-ubi-installer/releases/download/v1.1.4/openwrt-24.10.0-mediatek-mt7622-linksys_e8450-ubi-squashfs-sysupgrade.itb"
```

```sh
ssh root@192.168.1.1
```

```sh
# backup
mkdir /tmp/boot_backup
mount -t ubifs ubi0:boot_backup /tmp/boot_backup
exit
```

```sh
# copy backup
scp -O root@192.168.1.1:/tmp/boot_backup/mtd* ./
```

```sh
ssh root@192.168.1.1
```

```sh
# upgrade firmware
opkg update
opkg install luci-app-attendedsysupgrade
```

## Links

- https://firmware-selector.openwrt.org
- https://github.com/dangowrt/owrt-ubi-installer
