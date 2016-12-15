TOOL_PATH=$(pwd)/build
IMAGE_OUT_PATH=$(pwd)/rockimg/
IMAGE_RELEASE_PATH=$(pwd)/rockimg/Image-release
KERNEL_PATH=$(pwd)/kernel
UBOOT_PATH=$(pwd)/u-boot

#cd buildroot && make && cd -
mkdir -p $IMAGE_OUT_PATH
echo "Package rootfs.img now"
source $(pwd)/device/rockchip/rk3399/mkrootfs.sh
cp $(pwd)/buildroot/output/images/rootfs.ext4 $IMAGE_OUT_PATH/rootfs.img

cp $KERNEL_PATH/kernel.img $IMAGE_OUT_PATH
cp $KERNEL_PATH/resource.img $IMAGE_OUT_PATH
#cp $UBOOT_PATH/*MiniLoaderAll_*.bin $IMAGE_OUT_PATH/MiniLoaderAll.bin
#cp $UBOOT_PATH/uboot.img $IMAGE_OUT_PATH
cp $(pwd)/device/rockchip/rk3399/rockimg/RK3399MiniLoaderAll_V1.05.bin $IMAGE_OUT_PATH/
cp $(pwd)/device/rockchip/rk3399/rockimg/parameter.txt $IMAGE_OUT_PATH/
cp $(pwd)/device/rockchip/rk3399/rockimg/uboot.img $IMAGE_OUT_PATH/
cp $(pwd)/device/rockchip/rk3399/rockimg/trust.img $IMAGE_OUT_PATH/
echo 'Image: image in rockimg is ready'
