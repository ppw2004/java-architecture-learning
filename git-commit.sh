#!/bin/bash

#####################################
# Git 自动提交脚本
# 用户: ppw2004
# 邮箱: pengpeiwen2004@gmail.com
#####################################

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# 配置Git用户信息
GIT_NAME="ppw2004"
GIT_EMAIL="pengpeiwen2004@gmail.com"

# 设置Git用户信息
setup_git_config() {
    git config user.name "$GIT_NAME"
    git config user.email "$GIT_EMAIL"
    echo -e "${GREEN}✓ Git用户配置完成${NC}"
    echo -e "  用户名: ${BLUE}$GIT_NAME${NC}"
    echo -e "  邮箱: ${BLUE}$GIT_EMAIL${NC}"
}

# 显示状态
show_status() {
    echo -e "\n${BLUE}=== Git 状态 ===${NC}"
    git status
}

# 添加所有更改
add_changes() {
    echo -e "\n${GREEN}=== 添加更改 ===${NC}"
    git add .
    echo -e "${GREEN}✓ 已添加所有更改${NC}"
}

# 提交更改
commit_changes() {
    local commit_msg="$1"

    if [ -z "$commit_msg" ]; then
        # 如果没有提供commit message，使用默认的
        commit_msg="docs: update learning notes and progress $(date +'%Y-%m-%d %H:%M')"
    fi

    echo -e "\n${GREEN}=== 提交更改 ===${NC}"
    echo -e "提交信息: ${BLUE}$commit_msg${NC}"

    # 提交更改
    git commit -m "$commit_msg"

    if [ $? -eq 0 ]; then
        echo -e "${GREEN}✓ 提交成功${NC}"
    else
        echo -e "${RED}✗ 没有需要提交的更改${NC}"
        exit 1
    fi
}

# 推送到远程仓库
push_changes() {
    echo -e "\n${GREEN}=== 推送到远程仓库 ===${NC}"

    # 获取当前分支名
    local current_branch=$(git branch --show-current)
    echo -e "当前分支: ${BLUE}$current_branch${NC}"

    # 检查远程仓库是否存在
    if git remote get-url origin &> /dev/null; then
        echo -e "正在推送到 origin/$current_branch..."

        # 推送到远程仓库
        if git push origin "$current_branch"; then
            echo -e "${GREEN}✓ 推送成功${NC}"
        else
            echo -e "${RED}✗ 推送失败${NC}"
            echo -e "${YELLOW}可能需要身份验证，请手动执行: git push${NC}"
            exit 1
        fi
    else
        echo -e "${YELLOW}⚠ 未配置远程仓库${NC}"
        echo -e "如需推送，请先添加远程仓库:"
        echo -e "  ${BLUE}git remote add origin <your-repo-url>${NC}"
    fi
}

# 主函数
main() {
    echo -e "${BLUE}╔══════════════════════════════════════╗${NC}"
    echo -e "${BLUE}║     Git 自动提交脚本               ║${NC}"
    echo -e "${BLUE}╚══════════════════════════════════════╝${NC}"

    # 检查是否在Git仓库中
    if ! git rev-parse --git-dir > /dev/null 2>&1; then
        echo -e "${RED}✗ 错误: 当前目录不是Git仓库${NC}"
        echo -e "${YELLOW}请先初始化Git仓库: git init${NC}"
        exit 1
    fi

    # 设置Git配置
    setup_git_config

    # 显示当前状态
    show_status

    # 询问是否继续
    echo -e "\n${YELLOW}是否继续提交? (y/n)${NC}"
    read -r response

    if [[ ! "$response" =~ ^[Yy]$ ]]; then
        echo -e "${RED}✗ 已取消${NC}"
        exit 0
    fi

    # 添加更改
    add_changes

    # 提交更改
    commit_msg="${1:-}"
    commit_changes "$commit_msg"

    # 询问是否推送
    echo -e "\n${YELLOW}是否推送到远程仓库? (y/n)${NC}"
    read -r push_response

    if [[ "$push_response" =~ ^[Yy]$ ]]; then
        push_changes
    else
        echo -e "${YELLOW}✓ 已跳过推送，如需推送请运行: git push${NC}"
    fi

    echo -e "\n${GREEN}=== 完成 ===${NC}"
}

# 检查参数
if [ "$1" = "-h" ] || [ "$1" = "--help" ]; then
    echo "用法: $0 [commit-message]"
    echo ""
    echo "示例:"
    echo "  $0                    # 使用默认提交信息"
    echo "  $0 \"添加学习笔记\"    # 使用自定义提交信息"
    echo ""
    echo "配置:"
    echo "  用户名: $GIT_NAME"
    echo "  邮箱: $GIT_EMAIL"
    exit 0
fi

# 运行主函数
main "$@"
