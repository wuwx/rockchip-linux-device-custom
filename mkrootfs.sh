#! /bin/bash

top_dir=$(pwd)
BUILDROOT_PATH=$(pwd)/buildroot/

echo "build rootfs"
cd $BUILDROOT_PATH && make && cd ..
echo "build rootfs Done..."
