TOOL_PATH=$(pwd)/build
IMAGE_OUT_PATH=$(pwd)/rockimg
IMAGE_RELEASE_PATH=$(pwd)/rockimg/Image-release
KERNEL_PATH=$(pwd)/kernel
UBOOT_PATH=$(pwd)/u-boot
ROOTFS_PATH=$(pwd)/rootfs

if [ $1 = buildroot ]
then
    #cd buildroot && make && cd -
    rm -rf $IMAGE_OUT_PATH
    mkdir -p $IMAGE_OUT_PATH
    echo "Package rootfs.img now"
    source $(pwd)/device/rockchip/rk3399/mkrootfs.sh
    cp $(pwd)/buildroot/output/images/rootfs.ext4 $IMAGE_OUT_PATH/rootfs.img
elif [ $1 = debian ]
then
    echo "Package rootfs.img now"
    cp $ROOTFS_PATH/linaro-rootfs.img $IMAGE_OUT_PATH/rootfs.img
else
    echo -e "\e[31m error: please use the ./mkfirmware.sh debian or ./mkfirmware.sh buildroot \e[0m"
fi

cp $(pwd)/device/rockchip/rk3399/rockimg/parameter.txt $IMAGE_OUT_PATH/

if [ -f $UBOOT_PATH/uboot.img ]
then
        echo -n "create uboot.img..."
        cp -a $UBOOT_PATH/uboot.img $IMAGE_OUT_PATH/uboot.img
        echo "done."
else
        echo -e "\e[31m error: $UBOOT_PATH/uboot.img not fount! Please make it from $UBOOT_PATH first! \e[0m"
	exit 0
fi

if [ -f $UBOOT_PATH/trust.img ]
then
        echo -n "create trust.img..."
        cp -a $UBOOT_PATH/trust.img $IMAGE_OUT_PATH/trust.img
        echo "done."
else
        echo -e "\e[31m error: $UBOOT_PATH/trust.img not fount! Please make it from $UBOOT_PATH first! \e[0m"
	exit 0
fi

if [ -f $UBOOT_PATH/*_loader_*.bin ]
then
        echo -n "create loader..."
        cp -a $UBOOT_PATH/*_loader_*.bin $IMAGE_OUT_PATH/MiniLoaderAll.bin
        echo "done."
else
	echo -e "\e[31m error: $UBOOT_PATH/*loader_*.bin not fount,or there are multiple loaders! Please make it from $UBOOT_PATH first! \e[0m"
	rm $UBOOT_PATH/*_loader_*.bin
	exit 0
fi

if [ -f $KERNEL_PATH/resource.img ]
then
        echo -n "create resource.img..."
        cp -a $KERNEL_PATH/resource.img $IMAGE_OUT_PATH/resource.img
        echo "done."
else
        echo -e "\e[31m error: $KERNEL_PATH/resource.img not fount! \e[0m"
	exit 0
fi

if [ -f $KERNEL_PATH/kernel.img ]
then
        echo -n "create kernel.img..."
        cp -a $KERNEL_PATH/kernel.img $IMAGE_OUT_PATH/kernel.img
        echo "done."
else
        echo -e "\e[31m error: $KERNEL_PATH/kernel.img not fount! \e[0m"
	exit 0
fi
echo -e "\e[36m Image: image in rockimg is ready \e[0m"
