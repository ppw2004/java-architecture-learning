# Git 提交脚本使用说明

## 脚本说明

本项目提供了两个Git自动提交脚本，已配置好你的GitHub信息：
- **用户名**：ppw2004
- **邮箱**：pengpeiwen2004@gmail.com

## 1. 交互式提交脚本（推荐）

**文件**：`git-commit.sh`

**特点**：
- 交互式确认
- 显示详细状态
- 可选择是否推送
- 适合手动操作

**使用方法**：

```bash
# 使用默认提交信息
./git-commit.sh

# 使用自定义提交信息
./git-commit.sh "添加Java运行环境学习笔记"

# 查看帮助
./git-commit.sh --help
```

**执行流程**：
1. 设置Git用户信息
2. 显示当前Git状态
3. 询问是否继续
4. 添加所有更改
5. 提交更改
6. 询问是否推送到远程仓库

## 2. 快速提交脚本

**文件**：`git-quick-commit.sh`

**特点**：
- 无交互，自动执行
- 快速提交并推送
- 适合自动化场景

**使用方法**：

```bash
# 使用默认提交信息
./git-quick-commit.sh

# 使用自定义提交信息
./git-quick-commit.sh "feat: 添加Web前后端分离示例项目"
```

## 提交信息规范

建议遵循以下规范：

### 提交类型
- `docs`: 文档更新
- `feat`: 新功能
- `fix`: 修复bug
- `style`: 代码格式调整
- `refactor`: 重构代码
- `test`: 测试相关
- `chore`: 构建工具或辅助工具的变动

### 提交格式
```
<类型>: <简短描述>

详细描述（可选）
```

### 示例
```bash
./git-commit.sh "docs: 添加Java集合框架学习笔记"
./git-commit.sh "feat: 完成用户管理系统前后端分离示例"
./git-commit.sh "fix: 修复数据库连接配置问题"
./git-commit.sh "refactor: 优化项目目录结构"
```

## 使用场景

### 场景1：完成一天的学习笔记

```bash
# 添加所有更改并提交
./git-commit.sh "docs: 完成Java集合框架和IO学习笔记"
```

### 场景2：完成一个示例项目

```bash
# 提交项目代码
./git-commit.sh "feat: 添加Maven Hello World示例项目"
```

### 场景3：快速提交并推送

```bash
# 使用快速提交脚本
./git-quick-commit.sh "docs: 更新学习进度"
```

## 配置检查

脚本会自动设置以下Git配置：

```bash
git config user.name "ppw2004"
git config user.email "pengpeiwen2004@gmail.com"
```

检查当前配置：
```bash
git config user.name
git config user.email
```

## 常见问题

### Q1: 脚本没有执行权限

**解决**：
```bash
chmod +x git-commit.sh
chmod +x git-quick-commit.sh
```

### Q2: 推送失败，提示身份验证

**解决**：
1. 使用SSH密钥（推荐）
2. 或使用GitHub Personal Access Token
3. 配置Git凭据存储：
   ```bash
   git config --global credential.helper store
   ```

### Q3: 想要只提交不推送

**解决**：使用交互式脚本，在询问是否推送时选择 `n`

### Q4: 查看提交历史

**解决**：
```bash
git log --oneline --graph --all
```

## 与AI协作

当需要让我（AI）提交代码时，只需说：

```
请帮我提交代码
```

或指定提交信息：
```
请帮我提交代码，提交信息是"添加Java集合框架学习笔记"
```

我会自动使用 `git-quick-commit.sh` 脚本提交更改。

## 注意事项

1. **提交前检查**：确保只提交需要的文件
2. **敏感信息**：不要提交密码、密钥等敏感信息
3. **提交信息**：使用清晰、简洁的提交信息
4. **频繁提交**：建议每完成一个知识点就提交一次
5. **推送前检查**：确认提交信息正确后再推送

---

**创建时间**：2026-01-20
**用户**：ppw2004
**邮箱**：pengpeiwen2004@gmail.com
