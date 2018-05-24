#! /bin/bash

TOP_DIR=$(pwd)
BUILDROOT_PATH=$(pwd)/buildroot/
PRODUCT_PATH=$(pwd)/device/rockchip/rk3288


cd u-boot && ./make.sh fennec-rk3288 && cd -
./mk-kernel.sh
./mk-rootfs.sh
./mk-recovery.sh

