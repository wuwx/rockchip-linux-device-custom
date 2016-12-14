#! /bin/bash

TOP_DIR=$(pwd)
OUT_PATH=./out
BUILDROOT_PATH=$(pwd)/buildroot/
CLEAN_CMD=cleanthen

echo "build rootfs"
cd $BUILDROOT_PATH && make && cd ..

FILE='.rkmkdirs_first'
find $TOP_DIR -name rk_make_first.sh | sort -r > $FILE
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
find $TOP_DIR -name rk_make.sh | sort -r > $FILE
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
