#!/bin/sh
mount /dev/$1 /mnt/sdcard
echo /dev/$1 > /sys/kernel/config/usb_gadget/g1/functions/mass_storage.0/lun.0/file 

sync
