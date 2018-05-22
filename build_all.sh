#! /bin/bash

TOP_DIR=$(pwd)
BUILDROOT_PATH=$(pwd)/buildroot/
PRODUCT_PATH=$(pwd)/device/rockchip/rk3399


cd u-boot && ./make.sh evb-rk3399 && cd -
./mk-kernel.sh
./mk-rootfs.sh
./mk-recovery.sh

