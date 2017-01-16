TOOL_PATH=$(pwd)/build
IMAGE_OUT_PATH=$(pwd)/rockimg/
IMAGE_DEBIAN_PATH=$(pwd)/rockimg/Image-debian
KERNEL_PATH=$(pwd)/kernel
UBOOT_PATH=$(pwd)/u-boot
ROOTFS_PATH=$(pwd)/rootfs

#cd buildroot && make && cd -
mkdir -p $IMAGE_OUT_PATH
mkdir -p $IMAGE_DEBIAN_PATH
cp $ROOTFS_PATH/linaro-rootfs.img $IMAGE_DEBIAN_PATH/
cp $KERNEL_PATH/kernel.img $IMAGE_DEBIAN_PATH
cp $KERNEL_PATH/resource.img $IMAGE_DEBIAN_PATH
#cp $UBOOT_PATH/*MiniLoaderAll_*.bin $IMAGE_DEBIAN_PATH/MiniLoaderAll.bin
#cp $UBOOT_PATH/uboot.img $IMAGE_DEBIAN_PATH
cp $(pwd)/device/rockchip/rk3399/rockimg/RK3399MiniLoaderAll_V1.05.bin $IMAGE_DEBIAN_PATH/
cp $(pwd)/device/rockchip/rk3399/rockimg/parameter.txt $IMAGE_DEBIAN_PATH/
cp $(pwd)/device/rockchip/rk3399/rockimg/uboot.img $IMAGE_DEBIAN_PATH/
cp $(pwd)/device/rockchip/rk3399/rockimg/trust.img $IMAGE_DEBIAN_PATH/
echo 'Image: image in rockimg/Image-debian is ready'
