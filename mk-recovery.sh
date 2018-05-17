#!/bin/bash

PROJECT_DIR=$(pwd)
KERNEL_IMAGE=$PROJECT_DIR/kernel/arch/arm64/boot/Image
RAMDISK_IMAGE=$PROJECT_DIR/buildroot/output/images/rootfs.cpio.gz
KERNEL_DTB=$PROJECT_DIR/kernel/resource.img
RECOVERY_IMAGE=$PROJECT_DIR/rockimg/recovery.img
echo "create recovery.img"
echo -n "pack recovery image..."
$PROJECT_DIR/kernel/scripts/mkbootimg --kernel $KERNEL_IMAGE --ramdisk $RAMDISK_IMAGE --second $KERNEL_DTB -o $RECOVERY_IMAGE
echo "done."
