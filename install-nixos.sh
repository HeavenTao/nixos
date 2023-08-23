#!/usr/bin/env bash
disk=${1:?"disk not set"}
bootSize="513MiB";
swapSize=${2:-"4096MiB"}

#check disk if exists
fdisk -l | grep $disk
if [ "$?" = "0" ]; then
    echo "check disk exists:${disk} exists"
else
    echo "${disk} not exists"
fi

# parted
let endSize=${bootSize%MiB}+${swapSize%MiB}
parted $disk mklabel gpt
parted $disk mkpart ESP fat32 1MiB $bootSize
parted $disk set 1 esp on
parted $disk mkpart primary linux-swap $bootSize "${endSize}MiB"
parted $disk mkpart primary "${endSize}MiB" 100%
fdisk -l $disk
