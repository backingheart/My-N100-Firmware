#!/bin/bash

## 1. 修改默认管理 IP 为 192.168.5.1
sed -i 's/192.168.1.1/192.168.5.1/g' package/base-files/files/bin/config_generate

## 2. 强力锁定分区大小，避免被源码默认值覆盖
## 删除现有的分区设置，然后在文件末尾重新注入 256MB 内核和 1024MB 根分区
sed -i '/CONFIG_TARGET_KERNEL_PARTSIZE/d' .config
echo "CONFIG_TARGET_KERNEL_PARTSIZE=256" >> .config

sed -i '/CONFIG_TARGET_ROOTFS_PARTSIZE/d' .config
echo "CONFIG_TARGET_ROOTFS_PARTSIZE=1024" >> .config

## 3. 设置默认主机名为 MyOpenwrt
sed -i 's/OpenWrt/MyOpenwrt/g' package/base-files/files/bin/config_generate
