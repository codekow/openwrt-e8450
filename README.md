# Notes about E8450 UBI

This contains a collection of notes for using an e8450 with openWRT.

## Links

- [Online - Firmware Builder](https://firmware-selector.openwrt.org)
- [UBI Firmware Converter E8450](https://github.com/dangowrt/owrt-ubi-installer)

## Downloads

- [Initramfs - Recovery Installer](https://github.com/dangowrt/owrt-ubi-installer/releases/download/v1.1.4/openwrt-24.10.0-mediatek-mt7622-linksys_e8450-ubi-initramfs-recovery-installer.itb)
- [Initramfs - Recovery Installer (Signed)](https://github.com/dangowrt/owrt-ubi-installer/releases/download/v1.1.4/openwrt-24.10.0-mediatek-mt7622-linksys_e8450-ubi-initramfs-recovery-installer_signed.itb)
- [Sysupgrade - 24.10.0](https://github.com/dangowrt/owrt-ubi-installer/releases/download/v1.1.4/openwrt-24.10.0-mediatek-mt7622-linksys_e8450-ubi-squashfs-sysupgrade.itb)

```sh
# make scratch area
mkdir scratch
cd scratch

# download files

# installers
wget -N "https://github.com/dangowrt/owrt-ubi-installer/releases/download/v1.1.4/openwrt-24.10.0-mediatek-mt7622-linksys_e8450-ubi-initramfs-recovery-installer.itb"
wget -N "https://github.com/dangowrt/owrt-ubi-installer/releases/download/v1.1.4/openwrt-24.10.0-mediatek-mt7622-linksys_e8450-ubi-initramfs-recovery-installer_signed.itb"

# recovery only
wget -N "https://github.com/dangowrt/owrt-ubi-installer/releases/download/v1.1.4/openwrt-24.10.0-mediatek-mt7622-linksys_e8450-ubi-initramfs-recovery.itb"

# new firmware
wget -N "https://github.com/dangowrt/owrt-ubi-installer/releases/download/v1.1.4/openwrt-24.10.0-mediatek-mt7622-linksys_e8450-ubi-squashfs-sysupgrade.itb"
```

Router Login / Load firmware

- https://192.168.1.1 (default)
- https://10.0.1.1 (lan -> wan cable)

Firmware Upgrade Page

- https://192.168.1.1/config-admin-firmware.html#firmware

Shell on OpenWRT

```sh
ssh root@192.168.1.1
```

Backup - using recovery (alternative)

```sh
# backup
mkdir /tmp/boot_backup
cd /tmp/boot_backup

for i in /dev/mtd?ro
do
  cp $i .
done

md5sum mtd* > md5sum
exit
```

Backup - after ubi convert

```sh
# backup
mkdir /tmp/boot_backup
mount -t ubifs ubi0:boot_backup /tmp/boot_backup
exit
```

```sh
# copy backup
scp -O root@192.168.1.1:/tmp/boot_backup/m* ./
md5sum mtd* > md5sum
```

Install additional packages

```sh
scp -O packages-plus.txt root@192.168.1.1:/tmp

ssh root@192.168.1.1
```

```sh
opkg update
cat /tmp/packages-plus.txt | xargs opkg install
```

```sh
opkg install luci-app-attendedsysupgrade

# upgrade cli - 24.10.0+
opkg update && opkg install owut

owut check -v
owut upgrade -v
```

```sh
rsync -avz --no-owner --no-group files/ root@192.168.1.1:/
```
