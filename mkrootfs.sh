#! /bin/bash

top_dir=$(pwd)
BUILDROOT_PATH=$(pwd)/buildroot/

echo "build rootfs"
cd $BUILDROOT_PATH && make && cd ..

if [ -d $top_dir/out ]
then
cp $BUILDROOT_PATH/output/images/rootfs.ext4 $top_dir/out/rootfs.img
fi

echo "build rootfs Done..."
