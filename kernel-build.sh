#!/usr/bin/env bash

sudo apt update && sudo apt -y upgrade
sudo apt -y install bc
git clone --depth 1 https://github.com/Retro-Arena/linux.git -b odroidxu3-3.10.y odroidxu3-3.10.y
cd odroidxu3-3.10.y
make odroidxu3_defconfig
make -j8
sudo make modules_install
sudo cp -f arch/arm/boot/zImage /media/boot
sudo cp -f arch/arm/boot/dts/exynos5422-odroidxu3.dtb /media/boot
sync
sudo cp .config /boot/config-`make kernelrelease`
sudo update-initramfs -c -k `make kernelrelease`
sudo mkimage -A arm -O linux -T ramdisk -C none -a 0 -e 0 -n uInitrd -d /boot/initrd.img-`make kernelrelease` /boot/uInitrd-`make kernelrelease`
sudo cp /boot/uInitrd-`make kernelrelease` /media/boot/uInitrd
sync
sudo sync
