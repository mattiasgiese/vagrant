#!/bin/bash
DEVICE=/dev/sdb
MOUNTPOINT=/var/satellite

parted $DEVICE mklabel msdos
parted $DEVICE mkpart primary 2048 100%
mkfs.ext4 "${DEVICE}1"
mkdir $MOUNTPOINT
echo $(blkid "${DEVICE}1" | awk '{print$2}' | sed -e 's/"//g') $MOUNTPOINT ext4 noatime,nobarrier 0 0 >> /etc/fstab
mount $MOUNTPOINT