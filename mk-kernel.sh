#!/bin/bash

KERNEL_PATH=$(pwd)/../../../kernel
PATCH_NUM=`ls $(pwd)/patch/kernel | wc -l`

source $(pwd)/package_config.sh
if [ "$PLATFORM_WAYLAND"x = "no"x ];then

	if [ $PATCH_NUM -ne "0" ];then
		FILE='.kernel-rockchip-patch'
		ls $(pwd)/patch/kernel | sort -n > $(pwd)/patch/kernel/$FILE
		while read line;do
		patch=$(echo $line | sed -r 's@^(/.*/)[^/]+/?@\1@g')
		cp $(pwd)/patch/kernel/$patch $KERNEL_PATH
		cd $KERNEL_PATH
		git apply --check $patch 1> /dev/null  2>&1
		if [ $? -eq "0" ]; then
			git apply $patch
		fi
		cd -
		done < $(pwd)/patch/kernel/$FILE
		rm $(pwd)/patch/kernel/$FILE
	fi
fi

#cd $KERNEL_PATH
#make ARCH=arm64 rockchip_linux_defconfig
#make ARCH=arm64 rk3399-sapphire-excavator-linux.img -j12

