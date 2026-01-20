#!/bin/bash
# ============================================
# Java 环境检测脚本 (Linux/macOS)
# 用途: 检测系统中是否安装了 Java 及其版本信息
# ============================================

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}========================================${NC}"
echo -e "      Java 环境检测工具 (Linux/macOS)"
echo -e "${BLUE}========================================${NC}"
echo ""

# 检测 java 命令
echo -e "[1/6] 检测 Java 命令..."
if command -v java &> /dev/null; then
    echo -e "${GREEN}✓${NC} Java 命令已找到"
    JAVA_PATH=$(which java)
    echo -e "  路径: ${JAVA_PATH}"
else
    echo -e "${RED}✗${NC} 未找到 Java 命令"
    echo ""
    echo "请先安装 JDK 或配置 JAVA_HOME 环境变量"
    exit 1
fi
echo ""

# 获取 Java 版本
echo -e "[2/6] 检测 Java 版本信息..."
JAVA_VERSION=$(java -version 2>&1 | head -n 1)
echo -e "${GREEN}Java 版本:${NC} ${JAVA_VERSION}"
echo ""

# 获取 Java 详细信息
echo -e "[3/6] 获取 Java 详细信息..."
java -version 2>&1 | while read line; do
    echo "  ${line}"
done
echo ""

# 检查 JAVA_HOME 环境变量
echo -e "[4/6] 检查 JAVA_HOME 环境变量..."
if [ -z "$JAVA_HOME" ]; then
    echo -e "${YELLOW}⚠${NC} JAVA_HOME 环境变量未设置"
    echo "  建议设置 JAVA_HOME 指向 JDK 安装目录"

    # 尝试自动检测 JAVA_HOME
    DETECTED_HOME=$(dirname $(dirname $(readlink -f $(which java))))
    if [ -d "$DETECTED_HOME" ]; then
        echo "  检测到可能的 JAVA_HOME: ${DETECTED_HOME}"
    fi
else
    echo -e "${GREEN}✓${NC} JAVA_HOME: ${JAVA_HOME}"

    # 验证 JAVA_HOME 下的 java
    if [ -f "$JAVA_HOME/bin/java" ]; then
        echo -e "${GREEN}✓${NC} java 存在于 \$JAVA_HOME/bin/"
    else
        echo -e "${RED}✗${NC} 在 \$JAVA_HOME/bin/ 下未找到 java"
    fi
fi
echo ""

# 检查 javac 编译器
echo -e "[5/6] 检查 Java 编译器 (javac)..."
if command -v javac &> /dev/null; then
    echo -e "${GREEN}✓${NC} javac 命令已找到"

    # 获取 javac 版本
    JAVAC_VERSION=$(javac -version 2>&1)
    echo "  javac 版本: ${JAVAC_VERSION}"
else
    echo -e "${YELLOW}⚠${NC} 未找到 javac 命令"
    echo "  可能只安装了 JRE，建议安装完整 JDK"
fi
echo ""

# 检查常见 Java 安装位置
echo -e "[6/6] 检查系统中的 Java 安装..."
JAVA_LOCATIONS=(
    "/usr/lib/jvm"
    "/usr/java"
    "/usr/local/java"
    "/Library/Java/JavaVirtualMachines"
    "/opt/java"
)

FOUND=0
for location in "${JAVA_LOCATIONS[@]}"; do
    if [ -d "$location" ]; then
        if [ "$(ls -A $location 2>/dev/null)" ]; then
            echo -e "${GREEN}✓${NC} 找到 Java 安装目录: ${location}"
            ls -1 "$location" 2>/dev/null | while read dir; do
                echo "    - ${dir}"
            done
            FOUND=1
        fi
    fi
done

if [ $FOUND -eq 0 ]; then
    echo -e "${YELLOW}⚠${NC} 未在常见位置找到 Java 安装"
fi
echo ""

# 显示环境变量
echo -e "${BLUE}========================================${NC}"
echo "相关环境变量"
echo -e "${BLUE}========================================${NC}"
echo "JAVA_HOME: ${JAVA_HOME:-未设置}"
echo "PATH: ${PATH}"
echo ""

# 环境检查总结
echo -e "${BLUE}========================================${NC}"
echo "环境检查总结"
echo -e "${BLUE}========================================${NC}"

WARNINGS=0

if [ -z "$JAVA_HOME" ]; then
    echo -e "${YELLOW}⚠${NC} 建议: 配置 JAVA_HOME 环境变量"
    WARNINGS=$((WARNINGS + 1))
fi

if ! command -v javac &> /dev/null; then
    echo -e "${YELLOW}⚠${NC} 建议: 安装完整 JDK (包含 javac 编译器)"
    WARNINGS=$((WARNINGS + 1))
fi

if [ $WARNINGS -eq 0 ]; then
    echo -e "${GREEN}✓${NC} Java 环境配置完整！"
fi
echo ""

echo "检测完成！"
echo ""

# 提供安装建议
if ! command -v java &> /dev/null; then
    echo -e "${BLUE}========================================${NC}"
    echo "Java 安装建议"
    echo -e "${BLUE}========================================${NC}"
    echo ""
    echo "Ubuntu/Debian:"
    echo "  sudo apt update"
    echo "  sudo apt install openjdk-17-jdk"
    echo ""
    echo "CentOS/RHEL:"
    echo "  sudo yum install java-17-openjdk-devel"
    echo ""
    echo "macOS (使用 Homebrew):"
    echo "  brew install openjdk@17"
    echo ""
fi
