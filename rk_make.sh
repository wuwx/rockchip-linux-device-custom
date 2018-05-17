#! /bin/sh

BUILDROOT_TARGET_PATH=$(pwd)/../../../buildroot/output/target/

source package_config.sh

#gpu
rm $BUILDROOT_TARGET_PATH/usr/lib/libwayland-egl.so*
rm $BUILDROOT_TARGET_PATH/usr/lib/libgbm.so*
rm $BUILDROOT_TARGET_PATH/usr/lib/libEGL.so*
rm $BUILDROOT_TARGET_PATH/usr/lib/libGLESv*
cp -d lib/gpu/* $BUILDROOT_TARGET_PATH/usr/lib/

if [[ "$PLATFORM_WAYLAND"x == "no"x  ]];then
	echo "PLATFORM_EGLFS"
	cp lib/libmali_eglfs.so $BUILDROOT_TARGET_PATH/usr/lib/libmali.so
else
	echo "PLATFORM_WAYLAND"
	cp lib/libmali_wayland.so $BUILDROOT_TARGET_PATH/usr/lib/libmali.so
fi

#sd udisk..
if [ "$enable_sdcard_udisk"x = "yes"x ];then
	echo "enable sdcard and udisk"
	mkdir -p $BUILDROOT_TARGET_PATH/mnt/sdcard/
	mkdir -p $BUILDROOT_TARGET_PATH/mnt/udisk/
	ln -s $BUILDROOT_TARGET_PATH/sdcard $BUILDROOT_TARGET_PATH/mnt/sdcard
	cp $(pwd)/etc/mount-sdcard.sh $BUILDROOT_TARGET_PATH/etc/
	cp $(pwd)/etc/mount-udisk.sh $BUILDROOT_TARGET_PATH/etc/
	cp $(pwd)/etc/umount-sdcard.sh $BUILDROOT_TARGET_PATH/etc/
	cp $(pwd)/etc/umount-udisk.sh $BUILDROOT_TARGET_PATH/etc/
	cp $(pwd)/etc/udev/rules.d/add-sdcard-udisk.rules  $BUILDROOT_TARGET_PATH/etc/udev/rules.d/
	cp $(pwd)/etc/udev/rules.d/remove-sdcard-udisk.rules  $BUILDROOT_TARGET_PATH/etc/udev/rules.d/
fi

#usb
if [ "$enable_usb"x = "yes"x ];then
	echo "enable usb"
	cp $(pwd)/usb/11usb.rules $BUILDROOT_TARGET_PATH/etc/udev/rules.d/
	cp $(pwd)/usb/S60usb $BUILDROOT_TARGET_PATH/etc/init.d/
	cp $(pwd)/usb/usb_config $BUILDROOT_TARGET_PATH/usr/bin/
fi

#adb
if [ "$enable_adb"x = "yes"x ];then
	echo "enable adb"
	cp $(pwd)/adb/adbd $BUILDROOT_TARGET_PATH/usr/bin/
	cp $(pwd)/adb/libcutils.so $BUILDROOT_TARGET_PATH/usr/lib/
fi

#dp firmware
cp -r lib/firmware/ $BUILDROOT_TARGET_PATH/lib/

#S12_launcher
if [[ "$PLATFORM_WAYLAND"x == "no"x  ]];then
	echo "PLATFORM_EGLFS"
	cp S50_launcher_eglfs $BUILDROOT_TARGET_PATH/etc/init.d/S50_launcher
else
	echo "PLATFORM_WAYLAND"
	cp S50_launcher_wayland $BUILDROOT_TARGET_PATH/etc/init.d/S50_launcher
fi
cp S10rk3399init $BUILDROOT_TARGET_PATH/etc/init.d/
cp S10ueventd $BUILDROOT_TARGET_PATH/etc/init.d/
cp S70mount $BUILDROOT_TARGET_PATH/etc/init.d/
cp alsa_conf/rt5651/alsa.conf $BUILDROOT_TARGET_PATH/usr/share/alsa/alsa.conf

#bluetooth
if [ "$enable_bluetooth"x = "yes"x ];then
	echo "enable bluetooth"
	mkdir -p $BUILDROOT_TARGET_PATH/etc/bluetooth/
	cp $(pwd)/bluetooth/broadcom/fw/* $BUILDROOT_TARGET_PATH/etc/bluetooth/
	cp $(pwd)/bluetooth/broadcom/brcm_patchram_plus $BUILDROOT_TARGET_PATH/usr/sbin/
	cp $(pwd)/bluetooth/broadcom/rkbt $BUILDROOT_TARGET_PATH/usr/bin/
fi

#wifi firmware
mkdir -p $BUILDROOT_TARGET_PATH/system/etc
cp -rf firmware $BUILDROOT_TARGET_PATH/system/etc/
cp -rf etc/dnsmasq.conf $BUILDROOT_TARGET_PATH/etc/

#libs for vpudec plugin,mpp decoder
cp bin/mpp_test/* $BUILDROOT_TARGET_PATH/usr/bin/
cp lib/mpp/* $BUILDROOT_TARGET_PATH/usr/lib/

#Character Font
cp -r lib/fonts $BUILDROOT_TARGET_PATH/usr/lib/

mkdir $BUILDROOT_TARGET_PATH/misc
mkdir $BUILDROOT_TARGET_PATH/data
