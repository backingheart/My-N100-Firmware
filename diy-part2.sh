#!/bin/bash
# Description: OpenWrt DIY script part 2 (Fixes & Configs)

# 1. 修改默认 IP -> 192.168.5.1
sed -i 's/192.168.1.1/192.168.5.1/g' package/base-files/files/bin/config_generate

# 2. 修改主机名 -> N100-Commander
sed -i 's/ImmortalWrt/N100-Commander/g' package/base-files/files/bin/config_generate

# -------------------------------------------------------------------------
# 🚨 核心修复: apk mkndx 索引报错 (V3 必须保留)
# -------------------------------------------------------------------------
echo "Executing V3 Fix: Neutralizing apk mkndx..."
find . -name "*.mk" -exec sed -i 's/apk mkndx/true/g' {} +

# 双重保险
if [ -f "include/image.mk" ]; then
    sed -i 's/apk mkndx/true/g' include/image.mk
fi
# -------------------------------------------------------------------------
