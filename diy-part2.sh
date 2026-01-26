#!/bin/bash

## 1. 修改默认管理 IP 为 192.168.5.1
sed -i 's/192.168.1.1/192.168.5.1/g' package/base-files/files/bin/config_generate

## 2. 设置默认主机名为 MyOpenwrt
sed -i 's/OpenWrt/MyOpenwrt/g' package/base-files/files/bin/config_generate

## 3. 修正时区为美西 (America/Los_Angeles)，对齐你的原生资产
sed -i "s/timezone='UTC'/timezone='PST8PDT,M3.2.0,M11.1.0'/g" package/base-files/files/bin/config_generate
sed -i "/timezone='PST8PDT,M3.2.0,M11.1.0'/a \ \ \ \ \ \ \ \ set system.@system[-1].zonename='America/Los_Angeles'" package/base-files/files/bin/config_generate

## 4. 强力锁定分区大小，避免被源码默认值覆盖
# 内核 256MB，根分区 1024MB，确保满血状态
sed -i '/CONFIG_TARGET_KERNEL_PARTSIZE/d' .config
echo "CONFIG_TARGET_KERNEL_PARTSIZE=256" >> .config

sed -i '/CONFIG_TARGET_ROOTFS_PARTSIZE/d' .config
echo "CONFIG_TARGET_ROOTFS_PARTSIZE=1024" >> .config

## 5. V3 特供：处决导致崩溃的 Shadowsocks-rust 与冗余依赖
# 这些代码直接在源码层执行，彻底解决 V2 遇到的内存溢出问题
rm -rf feeds/packages/net/shadowsocks-rust
rm -rf feeds/packages/net/jool
rm -rf feeds/packages/net/onionshare-cli

# 强制在 .config 中屏蔽编译，确保万无一失
sed -i '/CONFIG_PACKAGE_shadowsocks-rust-sslocal/d' .config
echo "CONFIG_PACKAGE_shadowsocks-rust-sslocal=n" >> .config
sed -i '/CONFIG_PACKAGE_shadowsocks-rust-ssserver/d' .config
echo "CONFIG_PACKAGE_shadowsocks-rust-ssserver=n" >> .config

## 6. 清理编译残留，释放 /tmp 空间
echo "Freeing up build space for MyOpenwrt V3..."
rm -rf /tmp/*
