#!/bin/bash
# Description: OpenWrt DIY script part 2 (After Update feeds)

# 1. 修改默认 IP (改为你习惯的网段，例如 192.168.100.1 避免冲突)
sed -i 's/192.168.1.1/192.168.5.1/g' package/base-files/files/bin/config_generate

# 2. 修改主机名
sed -i 's/ImmortalWrt/N100-Commander/g' package/base-files/files/bin/config_generate

# 3. 针对 N100 优化：解锁 CPU 性能模式 (可选，针对 N100 睿频)
# sed -i 's/ondemand/performance/g' package/kernel/linux/files/sysctl-ipq806x.conf

# -------------------------------------------------------------------------
# 🚨 BUG FIX: apk mkndx 索引报错修复 (V3 核心补丁)
# -------------------------------------------------------------------------
echo "Executing V3 Fix: Neutralizing apk mkndx..."

# 暴力替换所有 mk 文件中的命令
find . -name "*.mk" -exec sed -i 's/apk mkndx/true/g' {} +

# 针对 include/image.mk 做特定检查
if [ -f "include/image.mk" ]; then
    sed -i 's/apk mkndx/true/g' include/image.mk
fi
# -------------------------------------------------------------------------
