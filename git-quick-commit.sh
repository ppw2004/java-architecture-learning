#!/bin/bash

#####################################
# Git 快速提交脚本（无交互）
# 用户: ppw2004
# 邮箱: pengpeiwen2004@gmail.com
#####################################

# 配置
GIT_NAME="ppw2004"
GIT_EMAIL="pengpeiwen2004@gmail.com"

# 检查是否在Git仓库中
if ! git rev-parse --git-dir > /dev/null 2>&1; then
    echo "错误: 当前目录不是Git仓库"
    exit 1
fi

# 设置Git用户信息
git config user.name "$GIT_NAME"
git config user.email "$GIT_EMAIL"

# 添加所有更改
git add .

# 提交（使用传入的参数或默认信息）
if [ -n "$1" ]; then
    git commit -m "$1"
else
    git commit -m "docs: update learning notes and progress $(date +'%Y-%m-%d %H:%M')"
fi

# 如果提交成功，尝试推送
if [ $? -eq 0 ]; then
    echo "✓ 提交成功"
    echo "正在推送..."
    git push
else
    echo "没有需要提交的更改"
    exit 1
fi
