#! /bin/sh

TOP_DIR=$(pwd)
BUILDROOT_TARGET_PATH=$(pwd)/../../../buildroot/output/target/

cp S50rk3399init $BUILDROOT_TARGET_PATH/etc/init.d/
