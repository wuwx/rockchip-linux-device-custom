#! /bin/bash

top_dir=$(pwd)
BUILDROOT_PATH=$(pwd)/buildroot/

#define build err exit function
check_err_exit(){
  if [ $1 -ne "0" ]; then
     echo -e $MSG_ERR
     cd $TOP_DIR
     exit 2
  fi
}
echo "build and package rootfs"
cd $BUILDROOT_PATH
make -j8
check_err_exit $?
cd $top_dir
echo "build rootfs Done..."
