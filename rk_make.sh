#! /bin/sh

TOP_DIR=$(pwd)
BUILDROOT_TARGET_PATH=$(pwd)/../../../buildroot/output/target/

#gpu
rm $BUILDROOT_TARGET_PATH/usr/lib/libwayland-egl.so*
rm $BUILDROOT_TARGET_PATH/usr/lib/libgbm.so*
rm $BUILDROOT_TARGET_PATH/usr/lib/libEGL.so*
rm $BUILDROOT_TARGET_PATH/usr/lib/libGLESv*
cp -d lib/gpu/* $BUILDROOT_TARGET_PATH/usr/lib/

cp bin/Carmachine $BUILDROOT_TARGET_PATH/usr/bin/
cp S50rk3399init $BUILDROOT_TARGET_PATH/etc/init.d/
