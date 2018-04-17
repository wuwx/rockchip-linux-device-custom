TOOL_PATH=$(pwd)/build
IMAGE_OUT_PATH=$(pwd)/rockimg/
IMAGE_DEBIAN_PATH=$(pwd)/rockimg/Image-debian
KERNEL_PATH=$(pwd)/kernel
UBOOT_PATH=$(pwd)/u-boot
ROOTFS_PATH=$(pwd)/rootfs

mkdir -p $IMAGE_OUT_PATH
mkdir -p $IMAGE_DEBIAN_PATH
cp $ROOTFS_PATH/linaro-rootfs.img $IMAGE_DEBIAN_PATH/
cp $(pwd)/device/rockchip/rk3288/rockimg/parameter.txt $IMAGE_DEBIAN_PATH/

if [ -f $UBOOT_PATH/uboot.img ]
then
        echo -n "create uboot.img..."
        cp -a $UBOOT_PATH/uboot.img $IMAGE_DEBIAN_PATH/uboot.img
        echo "done."
else
        echo "$UBOOT_PATH/uboot.img not found! Please make it from $UBOOT_PATH first!"
fi

if [ -f $UBOOT_PATH/trust.img ]
then
        echo -n "create trust.img..."
        cp -a $UBOOT_PATH/trust.img $IMAGE_DEBIAN_PATH/trust.img
        echo "done."
else
        echo "$UBOOT_PATH/trust.img not found! Please make it from $UBOOT_PATH first!"
fi

if [ -f $UBOOT_PATH/*_loader_*.bin ]
then
        echo -n "create loader..."
        cp -a $UBOOT_PATH/*_loader_*.bin $IMAGE_DEBIAN_PATH/MiniLoaderAll.bin
        echo "done."
else
	echo "$UBOOT_PATH/*_loader_*.bin not found! Please make it from $UBOOT_PATH first!"
fi

if [ -f $KERNEL_PATH/resource.img ]
then
        echo -n "create resource.img..."
        cp -a $KERNEL_PATH/resource.img $IMAGE_DEBIAN_PATH/resource.img
        echo "done."
else
        echo "$KERNEL_PATH/resource.img not found!"
fi

if [ -f $KERNEL_PATH/kernel.img ]
then
        echo -n "create kernel.img..."
        cp -a $KERNEL_PATH/kernel.img $IMAGE_DEBIAN_PATH/kernel.img
        echo "done."
else
        echo "$KERNEL_PATH/kernel.img not found!"
fi
echo 'Image: image in rockimg/Image-debian is ready'
