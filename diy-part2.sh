#!/bin/bash

## 1. 修改默认管理 IP 为 192.168.5.1
sed -i 's/192.168.1.1/192.168.5.1/g' package/base-files/files/bin/config_generate

## 2. 设置默认主机名为 MyOpenwrt
sed -i 's/OpenWrt/MyOpenwrt/g' package/base-files/files/bin/config_generate

## 3. 修正时区为美西 (America/Los_Angeles)
sed -i "s/timezone='UTC'/timezone='PST8PDT,M3.2.0,M11.1.0'/g" package/base-files/files/bin/config_generate
sed -i "/timezone='PST8PDT,M3.2.0,M11.1.0'/a \ \ \ \ \ \ \ \ set system.@system[-1].zonename='America/Los_Angeles'" package/base-files/files/bin/config_generate

## 4. 强力锁定分区大小
sed -i '/CONFIG_TARGET_KERNEL_PARTSIZE/d' .config
echo "CONFIG_TARGET_KERNEL_PARTSIZE=256" >> .config
sed -i '/CONFIG_TARGET_ROOTFS_PARTSIZE/d' .config
echo "CONFIG_TARGET_ROOTFS_PARTSIZE=1024" >> .config

## 5. V2 特供：处决导致崩溃的 Shadowsocks-rust 与冗余依赖
rm -rf feeds/packages/net/shadowsocks-rust
rm -rf feeds/packages/net/jool
rm -rf feeds/packages/net/onionshare-cli

# 在 .config 中彻底锁定
sed -i '/CONFIG_PACKAGE_shadowsocks-rust-sslocal/d' .config
echo "CONFIG_PACKAGE_shadowsocks-rust-sslocal=n" >> .config
sed -i '/CONFIG_PACKAGE_shadowsocks-rust-ssserver/d' .config
echo "CONFIG_PACKAGE_shadowsocks-rust-ssserver=n" >> .config

## 6. 空间释放（已修正，防止越权报错）
echo "Environment check complete."
