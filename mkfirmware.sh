TOOL_PATH=$(pwd)/build
IMAGE_OUT_PATH=$(pwd)/rockimg
KERNEL_PATH=$(pwd)/kernel
UBOOT_PATH=$(pwd)/u-boot
ROOTFS_PATH=$(pwd)/rootfs
DEVICE_IMG_PATH=$(pwd)/device/rockchip/rk3399/rockimg
PARAMETER_PATH=$DEVICE_IMG_PATH/parameter.txt
OEM_IMG_PATH=$DEVICE_IMG_PATH/oem.img
USER_DATA_IMG_PATH=$DEVICE_IMG_PATH/userdata.img
MISC_IMG_PATH=$DEVICE_IMG_PATH/wipe_all-misc.img
ROOTFS_IMG_PATH=$(pwd)/buildroot/output/rockchip_rk3399/images/rootfs.ext4
RECOVERY_PATH=$(pwd)/buildroot/output/rockchip_rk3399_recovery/images/recovery.img
mkdir -p $IMAGE_OUT_PATH

if [ $1 = debian ]
then
	echo -n "create rootfs.img..."
	cp $ROOTFS_PATH/linaro-rootfs.img $IMAGE_OUT_PATH/rootfs.img
	echo "done."
else
	echo -n "create rootfs.img..."
	cp $ROOTFS_IMG_PATH $IMAGE_OUT_PATH/rootfs.img
	echo "done"
fi

if [ -f $RECOVERY_PATH ]
then
	echo -n "create recovery.img..."
	cp $RECOVERY_PATH $IMAGE_OUT_PATH/
	echo "done."
else
	echo -e "\e[31m error: $RECOVERY_PATH not found! \e[0m"
	exit 0
fi

if [ -f $MISC_IMG_PATH ]
then
	echo -n "create misc.img..."
	cp $MISC_IMG_PATH $IMAGE_OUT_PATH/
	echo "done."
else
	echo -e "\e[31m error: $MISC_IMG_PATH not found! \e[0m"
	exit 0
fi

if [ -f $PARAMETER_PATH ]
then
	echo -n "create parameter.txt..."
	cp $PARAMETER_PATH $IMAGE_OUT_PATH/
	echo "done."
else
	echo -e "\e[31m error: $PARAMETER_PATH not found! \e[0m"
	exit 0
fi

if [ -f $OEM_IMG_PATH ]
then
	echo -n "create oem.img..."
	cp $OEM_IMG_PATH $IMAGE_OUT_PATH/
	echo "done."
else
	echo -e "\e[31m error: $OEM_IMG_PATH not found! \e[0m"
	exit 0
fi

if [ -f $USER_DATA_IMG_PATH ]
then
	echo -n "create userdata.img..."
	cp $USER_DATA_IMG_PATH $IMAGE_OUT_PATH/
	echo "done."
else
	echo -e "\e[31m error: $USER_DATA_IMG_PATH not found! \e[0m"
	exit 0
fi

if [ -f $UBOOT_PATH/uboot.img ]
then
        echo -n "create uboot.img..."
        cp -a $UBOOT_PATH/uboot.img $IMAGE_OUT_PATH/uboot.img
        echo "done."
else
        echo -e "\e[31m error: $UBOOT_PATH/uboot.img not found! Please make it from $UBOOT_PATH first! \e[0m"
	exit 0
fi

if [ -f $UBOOT_PATH/trust.img ]
then
        echo -n "create trust.img..."
        cp -a $UBOOT_PATH/trust.img $IMAGE_OUT_PATH/trust.img
        echo "done."
else
        echo -e "\e[31m error: $UBOOT_PATH/trust.img not found! Please make it from $UBOOT_PATH first! \e[0m"
	exit 0
fi

if [ -f $UBOOT_PATH/*_loader_*.bin ]
then
        echo -n "create loader..."
        cp -a $UBOOT_PATH/*_loader_*.bin $IMAGE_OUT_PATH/MiniLoaderAll.bin
        echo "done."
else
	echo -e "\e[31m error: $UBOOT_PATH/*loader_*.bin not found,or there are multiple loaders! Please make it from $UBOOT_PATH first! \e[0m"
	rm $UBOOT_PATH/*_loader_*.bin
	exit 0
fi

if [ -f $KERNEL_PATH/boot.img ]
then
	echo -n "create boot.img..."
	cp -a $KERNEL_PATH/boot.img $IMAGE_OUT_PATH/boot.img
	echo "done."
else
	echo -e "\e[31m error: $KERNEL_PATH/boot.img not found! \e[0m"
	exit 0
fi

echo -e "\e[36m Image: image in rockimg is ready \e[0m"
