TOOL_PATH=$(pwd)/build
IMAGE_OUT_PATH=$(pwd)/rockimg/
IMAGE_RELEASE_PATH=$(pwd)/rockimg/Image-release
KERNEL_PATH=$(pwd)/kernel
UBOOT_PATH=$(pwd)/u-boot

#cd buildroot && make && cd -
rm -rf $IMAGE_OUT_PATH
mkdir -p $IMAGE_OUT_PATH
echo "Package rootfs.img now"
source $(pwd)/device/rockchip/rk3399/mkrootfs.sh
cp $(pwd)/buildroot/output/images/rootfs.ext4 $IMAGE_OUT_PATH/rootfs.img

cp $(pwd)/device/rockchip/rk3399/rockimg/parameter.txt $IMAGE_OUT_PATH/

if [ -f $UBOOT_PATH/uboot.img ]
then
        echo -n "create uboot.img..."
        cp -a $UBOOT_PATH/uboot.img $IMAGE_OUT_PATH/uboot.img
        echo "done."
else
        echo "$UBOOT_PATH/uboot.img not fount! Please make it from $UBOOT_PATH first!"
	cp $(pwd)/device/rockchip/rk3399/rockimg/uboot.img $IMAGE_OUT_PATH/
fi

if [ -f $UBOOT_PATH/trust.img ]
then
        echo -n "create trust.img..."
        cp -a $UBOOT_PATH/trust.img $IMAGE_OUT_PATH/trust.img
        echo "done."
else
        echo "$UBOOT_PATH/trust.img not fount! Please make it from $UBOOT_PATH first!"
	cp $(pwd)/device/rockchip/rk3399/rockimg/trust.img $IMAGE_OUT_PATH/
fi

if [ -f $UBOOT_PATH/*_loader_*.bin ]
then
        echo -n "create loader..."
        cp -a $UBOOT_PATH/*_loader_*.bin $IMAGE_OUT_PATH/MiniLoaderAll.bin
        echo "done."
else
	echo "$UBOOT_PATH/*MiniLoaderAll_*.bin not fount! Please make it from $UBOOT_PATH first!"
	cp $(pwd)/device/rockchip/rk3399/rockimg/MiniLoaderAll.bin $IMAGE_OUT_PATH/
fi

if [ -f $KERNEL_PATH/resource.img ]
then
        echo -n "create resource.img..."
        cp -a $KERNEL_PATH/resource.img $IMAGE_OUT_PATH/resource.img
        echo "done."
else
        echo "$KERNEL_PATH/resource.img not fount!"
fi

if [ -f $KERNEL_PATH/kernel.img ]
then
        echo -n "create kernel.img..."
        cp -a $KERNEL_PATH/kernel.img $IMAGE_OUT_PATH/kernel.img
        echo "done."
else
        echo "$KERNEL_PATH/kernel.img not fount!"
fi
echo 'Image: image in rockimg is ready'
