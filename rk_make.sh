#! /bin/sh

BUILDROOT_TARGET_PATH=$(pwd)/../../../buildroot/output/target/

#gpu
rm $BUILDROOT_TARGET_PATH/usr/lib/libwayland-egl.so*
rm $BUILDROOT_TARGET_PATH/usr/lib/libgbm.so*
rm $BUILDROOT_TARGET_PATH/usr/lib/libEGL.so*
rm $BUILDROOT_TARGET_PATH/usr/lib/libGLESv*
cp -d lib/gpu/* $BUILDROOT_TARGET_PATH/usr/lib/

#sd udisk..
mkdir -p $BUILDROOT_TARGET_PATH/mnt/sdcard/
mkdir -p $BUILDROOT_TARGET_PATH/mnt/udisk/
cp $(pwd)/etc/mount-sdcard.sh $BUILDROOT_TARGET_PATH/etc/
cp $(pwd)/etc/mount-udisk.sh $BUILDROOT_TARGET_PATH/etc/
cp $(pwd)/etc/umount-sdcard.sh $BUILDROOT_TARGET_PATH/etc/
cp $(pwd)/etc/umount-udisk.sh $BUILDROOT_TARGET_PATH/etc/
cp $(pwd)/etc/udev/rules.d/add-sdcard-udisk.rules  $BUILDROOT_TARGET_PATH/etc/udev/rules.d/
cp $(pwd)/etc/udev/rules.d/remove-sdcard-udisk.rules  $BUILDROOT_TARGET_PATH/etc/udev/rules.d/

#usb
cp $(pwd)/usb/11usb.rules $BUILDROOT_TARGET_PATH/etc/udev/rules.d/
cp $(pwd)/usb/S60usb $BUILDROOT_TARGET_PATH/etc/init.d/
cp $(pwd)/usb/usb_config $BUILDROOT_TARGET_PATH/usr/bin/

cp S50rk3399init $BUILDROOT_TARGET_PATH/etc/init.d/
cp alsa_conf/rt5651/alsa.conf $BUILDROOT_TARGET_PATH/usr/share/alsa/alsa.conf

mkdir -p $BUILDROOT_TARGET_PATH/etc/bluetooth/
cp $(pwd)/bluetooth/broadcom/fw/* $BUILDROOT_TARGET_PATH/etc/bluetooth/
cp $(pwd)/bluetooth/broadcom/brcm_patchram_plus $BUILDROOT_TARGET_PATH/usr/sbin/
cp $(pwd)/bluetooth/broadcom/rkbt $BUILDROOT_TARGET_PATH/usr/bin/

#wifi firmware
mkdir -p $BUILDROOT_TARGET_PATH/system/etc
cp -rf firmware $BUILDROOT_TARGET_PATH/system/etc/
cp -rf etc/dnsmasq.conf $BUILDROOT_TARGET_PATH/etc/

#libs for vpudec plugin,mpp decoder
cp bin/mpp_test/* $BUILDROOT_TARGET_PATH/usr/bin/
cp lib/mpp/* $BUILDROOT_TARGET_PATH/usr/lib/

#Character Font
cp -r lib/fonts $BUILDROOT_TARGET_PATH/usr/lib/
