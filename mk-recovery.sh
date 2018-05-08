#!/bin/bash

PROJECT_DIR=$(pwd)
BUILDROOT_DIR=$PROJECT_DIR/buildroot
TARGET_DIR=$BUILDROOT_DIR/output/target
RKINITRD_DIR=/tmp/rkinitrd
RAMDISK_DIR=$RKINITRD_DIR/ramdisk
KERNEL_DIR=$PROJECT_DIR/kernel
RECOVERY_DIR=$PROJECT_DIR/recovery
DEVICE_DIR=$PROJECT_DIR/device/rockchip/rk3399

echo "create recovery.img"
sudo rm -rf $RKINITRD_DIR
mkdir $RKINITRD_DIR
cp $DEVICE_DIR/rockimg/rootfs.cpio.gz $RKINITRD_DIR
echo -n "unpack ramdisk..."
gunzip $RKINITRD_DIR/rootfs.cpio.gz
mkdir $RAMDISK_DIR
cd $RAMDISK_DIR
sudo cpio -id < ../rootfs.cpio
echo "done."
cd $PROJECT_DIR
sudo cp -a $TARGET_DIR/usr/bin/update $RAMDISK_DIR/usr/bin/update
if [ -f $TARGET_DIR/usr/bin/recovery ]
then
        echo -n "copy recovery..."
        sudo cp -a $TARGET_DIR/usr/bin/recovery $RAMDISK_DIR/usr/bin/recovery
        echo "done."
else
	cd $BUILDROOT_DIR
	make recovery
	echo -n "copy recovery..."
	sudo cp -a $TARGET_DIR/usr/bin/recovery $RAMDISK_DIR/usr/bin/recovery
	echo "done."
fi

if [ -f $TARGET_DIR/usr/lib/libdrm.so ]
then
	echo -n "copy libdrm..."
	sudo cp -a $TARGET_DIR/usr/lib/libdrm.so* $RAMDISK_DIR/usr/lib/
	echo "done."
else
	cd $BUILDROOT_DIR
	make libdrm
	echo -n "copy libdrm..."
	sudo cp -a $TARGET_DIR/usr/lib/libdrm.so* $RAMDISK_DIR/usr/lib/
	echo "done."
fi


if [ -f $TARGET_DIR/usr/lib/libz.so ]
then
	echo -n "copy libz..."
	sudo cp -a $TARGET_DIR/usr/lib/libz.so* $RAMDISK_DIR/usr/lib/
	echo "done."
else
	cd $BUILDROOT_DIR
	make libz
	echo -n "copy libz..."
	sudo cp -a $TARGET_DIR/usr/lib/libz.so* $RAMDISK_DIR/usr/lib/
	echo "done."
fi

if [ -f $TARGET_DIR/usr/lib/libpng.so ]
then
	echo -n "copy libpng..."
	sudo cp -a $TARGET_DIR/usr/lib/libpng* $RAMDISK_DIR/usr/lib/
	echo "done."
else
	cd $BUILDROOT_DIR
	make libpng
	echo -n "copy libpng..."
	sudo cp -a $TARGET_DIR/usr/lib/libpng* $RAMDISK_DIR/usr/lib/
	echo "done."
fi

if [ -f $TARGET_DIR/usr/sbin/mke2fs ]
then
	echo -n "copy mke2fs..."
	sudo cp -a $TARGET_DIR/usr/sbin/mke2fs $RAMDISK_DIR/usr/sbin/mke2fs
	sudo cp -a $TARGET_DIR/etc/mke2fs.conf $RAMDISK_DIR/etc/mke2fs.conf
	sudo cp -a $TARGET_DIR/usr/sbin/e2fsck $RAMDISK_DIR/usr/sbin/e2fsck
	sudo ln -sf $RAMDISK_DIR/usr/sbin/mke2fs $RAMDISK_DIR/usr/sbin/mkfs.ext2
	sudo ln -sf $RAMDISK_DIR/usr/sbin/mke2fs $RAMDISK_DIR/usr/sbin/mkfs.ext3
	sudo ln -sf $RAMDISK_DIR/usr/sbin/mke2fs $RAMDISK_DIR/usr/sbin/mkfs.ext4
	sudo ln -sf $RAMDISK_DIR/usr/sbin/mke2fs $RAMDISK_DIR/usr/sbin/mkfs.ext4dev
	sudo ln -sf $RAMDISK_DIR/usr/sbin/e2fsck $RAMDISK_DIR/usr/sbin/fsck.ext2
	sudo ln -sf $RAMDISK_DIR/usr/sbin/e2fsck $RAMDISK_DIR/usr/sbin/fsck.ext3
	sudo ln -sf $RAMDISK_DIR/usr/sbin/e2fsck $RAMDISK_DIR/usr/sbin/fsck.ext4
	sudo ln -sf $RAMDISK_DIR/usr/sbin/e2fsck $RAMDISK_DIR/usr/sbin/fsck.ext4dev
	sudo cp -a $TARGET_DIR/usr/lib/libext2fs.so* $RAMDISK_DIR/usr/lib/
	sudo cp -a $TARGET_DIR/usr/lib/libcom_err.so* $RAMDISK_DIR/usr/lib/
	sudo cp -a $TARGET_DIR/usr/lib/libblkid.so* $RAMDISK_DIR/usr/lib/
	sudo cp -a $TARGET_DIR/lib/libblkid.so* $RAMDISK_DIR/lib/
	sudo cp -a $TARGET_DIR/usr/lib/libuuid.so* $RAMDISK_DIR/usr/lib/
	sudo cp -a $TARGET_DIR/lib/libuuid.so* $RAMDISK_DIR/lib/
	sudo cp -a $TARGET_DIR/usr/lib/libe2p.so* $RAMDISK_DIR/usr/lib/
	echo "done."
else
	cd $BUILDROOT_DIR
	make e2fsprogs
	echo -n "copy mke2fs..."
	sudo cp -a $TARGET_DIR/usr/sbin/mke2fs $RAMDISK_DIR/usr/sbin/mke2fs
	sudo cp -a $TARGET_DIR/etc/mke2fs.conf $RAMDISK_DIR/etc/mke2fs.conf
	sudo cp -a $TARGET_DIR/usr/sbin/e2fsck $RAMDISK_DIR/usr/sbin/e2fsck
	sudo ln -sf $RAMDISK_DIR/usr/sbin/mke2fs $RAMDISK_DIR/usr/sbin/mkfs.ext2
	sudo ln -sf $RAMDISK_DIR/usr/sbin/mke2fs $RAMDISK_DIR/usr/sbin/mkfs.ext3
	sudo ln -sf $RAMDISK_DIR/usr/sbin/mke2fs $RAMDISK_DIR/usr/sbin/mkfs.ext4
	sudo ln -sf $RAMDISK_DIR/usr/sbin/mke2fs $RAMDISK_DIR/usr/sbin/mkfs.ext4dev
	sudo ln -sf $RAMDISK_DIR/usr/sbin/e2fsck $RAMDISK_DIR/usr/sbin/fsck.ext2
	sudo ln -sf $RAMDISK_DIR/usr/sbin/e2fsck $RAMDISK_DIR/usr/sbin/fsck.ext3
	sudo ln -sf $RAMDISK_DIR/usr/sbin/e2fsck $RAMDISK_DIR/usr/sbin/fsck.ext4
	sudo ln -sf $RAMDISK_DIR/usr/sbin/e2fsck $RAMDISK_DIR/usr/sbin/fsck.ext4dev
	sudo cp -a $TARGET_DIR/usr/lib/libext2fs.so* $RAMDISK_DIR/usr/lib/
	sudo cp -a $TARGET_DIR/usr/lib/libcom_err.so* $RAMDISK_DIR/usr/lib/
	sudo cp -a $TARGET_DIR/usr/lib/libblkid.so* $RAMDISK_DIR/usr/lib/
	sudo cp -a $TARGET_DIR/lib/libblkid.so* $RAMDISK_DIR/lib/
	sudo cp -a $TARGET_DIR/usr/lib/libuuid.so* $RAMDISK_DIR/usr/lib/
	sudo cp -a $TARGET_DIR/lib/libuuid.so* $RAMDISK_DIR/lib/
	sudo cp -a $TARGET_DIR/usr/lib/libe2p.so* $RAMDISK_DIR/usr/lib/
	echo "done."
fi

sudo chown root:root $RAMDISK_DIR/usr/bin/recovery
sudo chown root:root $RAMDISK_DIR/usr/lib/libdrm.so*
sudo chown root:root $RAMDISK_DIR/usr/lib/libz.so*
sudo chown root:root $RAMDISK_DIR/usr/lib/libpng.so*
sudo chmod 777 $RAMDISK_DIR/usr/bin/recovery
sudo chmod 777 $RAMDISK_DIR/usr/lib/libdrm.so*
sudo chmod 777 $RAMDISK_DIR/usr/lib/libz.so*
sudo chmod 777 $RAMDISK_DIR/usr/lib/libpng*

echo -n "copy image for recovery..."
sudo mkdir -p $RAMDISK_DIR/res/images
sudo cp $RECOVERY_DIR/res/images/* $RAMDISK_DIR/res/images/
echo "done."

echo -n "copy init for recovery..."
sudo cp -a $DEVICE_DIR/recovery.init $RAMDISK_DIR/init
sudo chown root:root $RAMDISK_DIR/init
sudo chmod 755 $RAMDISK_DIR/init
echo "done."

echo -n "modify fstab..."
sudo cp -a $DEVICE_DIR/recovery.fstab $RAMDISK_DIR/etc/fstab
sudo chown root:root $RAMDISK_DIR/etc/fstab
sudo chmod 644 $RAMDISK_DIR/etc/fstab
sudo mkdir $RAMDISK_DIR/data
sudo chown root:root $RAMDISK_DIR/data
echo "done."
cd $RAMDISK_DIR

echo -n "pack cpio ram disk..."
sudo find . | sudo cpio --quiet -o -H newc > ../rootfs.new.cpio
cd $PROJECT_DIR
gzip $RKINITRD_DIR/rootfs.new.cpio
echo "done."

echo -n "pack recovery image..."
$KERNEL_DIR/scripts/mkbootimg --kernel $KERNEL_DIR/arch/arm64/boot/Image --ramdisk $RKINITRD_DIR/rootfs.new.cpio.gz --second $KERNEL_DIR/resource.img -o $PROJECT_DIR/rockimg/recovery.img
echo "done."
#sudo rm -rf /tmp/rkramdisk
