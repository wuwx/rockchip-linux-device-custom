#! /bin/bash

TOP_DIR=$(pwd)
OUT_PATH=./out
BUILDROOT_PATH=$(pwd)/buildroot/
CLEAN_CMD=cleanthen

echo "build rootfs"
cd $BUILDROOT_PATH && make && cd ..

echo "arm-linux-gcc envsetup..."
logfile="/dev/null"
check_cmd(){
    "$@" >> $logfile 2>&1
}
check_cc(){
  check_cmd arm-linux-gcc -v
}
check_cc
if [ $? -eq 127 ];then
  source envsetup.sh
fi
shopt -s expand_aliases
alias arm-linux-gcc='arm-linux-gcc -s -O2'
#alias arm-linux-gcc='arm-linux-gcc -g -rdynamic -O2'

FILE='.rkmkdirs_first'
find $TOP_DIR -path $TOP_DIR/buildroot -prune -o -name rk_make_first.sh -print | sort -r > $FILE
while read line;do
        #echo "Line # $k: $line"
        mk_path=$(echo $line | sed -r 's@^(/.*/)[^/]+/?@\1@g')
        cd $mk_path
        source $mk_path/rk_make_first.sh $1 $CLEAN_CMD
        cd $TOP_DIR
        #echo $mk_path
        #echo $(pwd)
done < $FILE
rm .rkmkdirs_first

FILE='.rkmkdirs'
find $TOP_DIR -path $TOP_DIR/buildroot -prune -o -name rk_make.sh -print | sort -r > $FILE
while read line;do
        #echo "Line # $k: $line"
	mk_path=$(echo $line | sed -r 's@^(/.*/)[^/]+/?@\1@g')
        cd $mk_path
	source $mk_path/rk_make.sh $1 $CLEAN_CMD
	cd $TOP_DIR
	#echo $mk_path
	#echo $(pwd)
done < $FILE
rm .rkmkdirs

echo "build all Done"
