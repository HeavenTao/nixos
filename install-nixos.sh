#!/usr/bin/env bash
disk=${1:?"disk not set"}
bootSize=${2:-"512MB"}
swapSize=${3:-"4096MB"}
echo $disk $bootSize $swapSize
parted disk -- mklabel gpt



