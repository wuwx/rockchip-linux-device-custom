#! /bin/bash
#
# Before build your RK3288 SDK, you must execute "source envsetup.sh" at
# SDK root to setup the build environment first.
#
# Adding your own useful commands and enviornment variables here is very welcome.
#
# If you have any question about build system of RK3288, please send a email to
# lby@rock-chips.com for help.
#

# Setup toolchain
toolschain_path=$(pwd)/buildroot/output/host/
version=$(arm-linux-gnueabihf-gcc --version 2>/dev/null)
result=$(echo $version | grep -Eo '*Buildroot 2016.08.1*')
if [ ! "$version" = "" ] && [ "$result" = "" ] ;then
	export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:$toolschain_path/usr/bin:$PATH"
	export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:$toolschain_path/usr/arm-rockchip-linux-gnueabihf/bin:$PATH"
	echo "Another gcc found, will be replaced by 3288-linux SDK toolchain"
elif [ "$version" = "" ] ;then
	export PATH="$PATH:$toolschain_path/usr/bin"
	export PATH="$PATH:$toolschain_path/usr/arm-rockchip-linux-gnueabihf/bin"

	version=$(arm-linux-gnueabihf-gcc --version)
	echo "Set toolchain path to: <SdkRoot>/buildroot/output/host/usr"
#	echo $version
fi

# Export 3288 sdk root directory
export RK3288_SDK_ROOT="$(pwd)"

# Set croot alias
alias croot="cd $(pwd)"

#define build err exit function
check_err_exit(){
  if [ $1 -ne "0" ]; then
     echo -e $MSG_ERR
     cd $TOP_DIR
     exit 2
  fi
}
export -f check_err_exit
