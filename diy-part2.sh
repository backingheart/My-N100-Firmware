#!/bin/bash
# 1. 修改默认IP
sed -i 's/192.168.1.1/192.168.5.1/g' package/base-files/files/bin/config_generate

# 2. 强力锁定分区大小（无论默认值是多少，全部强制重写）
sed -i '/CONFIG_TARGET_KERNEL_PARTSIZE/d' .config
echo "CONFIG_TARGET_KERNEL_PARTSIZE=256" >> .config

sed -i '/CONFIG_TARGET_ROOTFS_PARTSIZE/d' .config
echo "CONFIG_TARGET_ROOTFS_PARTSIZE=1024" >> .config
