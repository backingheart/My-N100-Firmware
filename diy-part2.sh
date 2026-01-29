#!/bin/bash
# 1. 改 IP
sed -i 's/192.168.1.1/192.168.5.1/g' package/base-files/files/bin/config_generate
# 2. 改名
sed -i 's/ImmortalWrt/N100-Commander/g' package/base-files/files/bin/config_generate
# 3. 强制驱动 (保险起见)
sed -i 's/CONFIG_PACKAGE_kmod-igc=m/CONFIG_PACKAGE_kmod-igc=y/g' .config || true
