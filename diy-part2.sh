#!/bin/bash
# 1. 修改默认IP为 192.168.5.1
sed -i 's/192.168.1.1/192.168.5.1/g' package/base-files/files/bin/config_generate

# 2. 修改分区大小：内核256MB，根分区1024MB
# 注意：这一步会寻找 .config 里的默认值并替换
sed -i 's/CONFIG_TARGET_KERNEL_PARTSIZE=16/CONFIG_TARGET_KERNEL_PARTSIZE=256/g' .config
sed -i 's/CONFIG_TARGET_ROOTFS_PARTSIZE=160/CONFIG_TARGET_ROOTFS_PARTSIZE=1024/g' .config
