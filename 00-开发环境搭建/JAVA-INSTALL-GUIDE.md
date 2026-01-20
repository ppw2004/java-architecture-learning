# Java 开发环境安装指南

本指南将帮助你在不同操作系统上安装和配置 Java 开发环境。

## 目录

- [系统要求](#系统要求)
- [Windows 安装](#windows-安装)
- [Linux 安装](#linux-安装)
- [macOS 安装](#macos-安装)
- [环境变量配置](#环境变量配置)
- [验证安装](#验证安装)
- [多版本 Java 管理](#多版本-java-管理)
- [常见问题](#常见问题)

---

## 系统要求

### 推荐配置

- **操作系统**: Windows 10+, Ubuntu 20.04+, macOS 10.15+
- **内存**: 至少 8GB RAM
- **磁盘空间**: 至少 2GB 可用空间
- **权限**: 管理员权限（用于安装）

### Java 版本选择

| 版本 | LTS | 发布时间 | 推荐场景 |
|------|-----|----------|----------|
| Java 8 | ✓ | 2014 | 遗留系统维护 |
| Java 11 | ✓ | 2018 | 稳定生产环境 |
| **Java 17** | ✓ | 2021 | **推荐用于新项目** |
| Java 21 | ✓ | 2023 | 最新 LTS，尝鲜使用 |
| Java 23 | ✗ | 2024 | 最新特性测试 |

**本项目推荐使用 Java 17 或 Java 21 LTS 版本**

---

## Windows 安装

### 方法一：使用安装包（推荐）

1. **下载 JDK**
   - 访问 [Oracle JDK](https://www.oracle.com/java/technologies/downloads/) 或
   - [OpenJDK](https://adoptium.net/)（推荐，免费）

2. **运行安装程序**
   ```cmd
   # 双击下载的 .exe 文件
   # 例如: jdk-17_windows-x64_bin.exe
   ```

3. **按照向导完成安装**
   - 默认安装路径: `C:\Program Files\Java\jdk-17`
   - 建议勾选"设置 JAVA_HOME 环境变量"

### 方法二：使用包管理器

**使用 Chocolatey:**
```powershell
# 安装 Chocolatey（如果未安装）
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))

# 安装 JDK
choco install openjdk17

# 验证安装
java -version
```

**使用 Winget:**
```powershell
# 搜索可用版本
winget search openjdk

# 安装 Eclipse Temurin 17 (推荐)
winget install EclipseAdoptium.Temurin.17.JDK

# 验证安装
java -version
```

---

## Linux 安装

### Ubuntu/Debian

```bash
# 更新包索引
sudo apt update

# 安装 OpenJDK 17
sudo apt install openjdk-17-jdk -y

# 验证安装
java -version
javac -version

# 查看安装位置
ls -la /usr/lib/jvm/
```

**安装其他版本:**
```bash
# Java 11
sudo apt install openjdk-11-jdk

# Java 21
sudo apt install openjdk-21-jdk

# 查看所有可用版本
apt search openjdk
```

### CentOS/RHEL/Rocky Linux

```bash
# 安装 OpenJDK 17
sudo yum install java-17-openjdk-devel -y

# 或者使用 dnf (CentOS 8+)
sudo dnf install java-17-openjdk-devel -y

# 验证安装
java -version
javac -version

# 查看安装版本
alternatives --config java
```

### Arch Linux

```bash
# 安装 OpenJDK
sudo pacman -S jdk17-openjdk

# 验证安装
java -version
```

---

## macOS 安装

### 方法一：使用 Homebrew（推荐）

```bash
# 安装 Homebrew（如果未安装）
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# 安装 OpenJDK
brew install openjdk@17

# 创建符号链接
sudo ln -sfn /opt/homebrew/opt/openjdk@17/libexec/openjdk.jdk \
  /Library/Java/JavaVirtualMachines/openjdk-17.jdk

# 验证安装
java -version
```

### 方法二：使用安装包

1. 访问 [Adoptium](https://adoptium.net/) 或 [Azul Zulu](https://www.azul.com/downloads/)
2. 下载 .pkg 文件
3. 双击安装

### 方法三：使用 SDKMAN!

```bash
# 安装 SDKMAN!
curl -s "https://get.sdkman.io" | bash
source "$HOME/.sdkman/bin/sdkman-init.sh"

# 列出可用版本
sdk list java

# 安装 Java 17
sdk install java 17.0.9-tem

# 切换默认版本
sdk default java 17.0.9-tem

# 验证安装
java -version
```

---

## 环境变量配置

### Windows

**使用图形界面:**

1. 右键"此电脑" → "属性" → "高级系统设置"
2. 点击"环境变量"
3. 在"系统变量"区域点击"新建"

**设置 JAVA_HOME:**
```
变量名: JAVA_HOME
变量值: C:\Program Files\Java\jdk-17
```

**更新 PATH:**
```
在 PATH 变量中添加: %JAVA_HOME%\bin
```

**使用命令行:**
```cmd
# 设置 JAVA_HOME
setx JAVA_HOME "C:\Program Files\Java\jdk-17" /M

# 添加到 PATH
setx PATH "%PATH%;%JAVA_HOME%\bin" /M

# 刷新环境变量
refreshenv
```

### Linux/macOS

**编辑 ~/.bashrc 或 ~/.zshrc:**
```bash
# 设置 JAVA_HOME
export JAVA_HOME=/usr/lib/jvm/java-17-openjdk

# 添加到 PATH
export PATH=$JAVA_HOME/bin:$PATH

# 使配置生效
source ~/.bashrc  # 或 source ~/.zshrc
```

**全局配置（所有用户）:**
```bash
# 编辑 /etc/environment
sudo nano /etc/environment

# 添加以下行
JAVA_HOME="/usr/lib/jvm/java-17-openjdk"
PATH="$JAVA_HOME/bin:$PATH"
```

---

## 验证安装

### 使用本项目的检测脚本

**Windows:**
```cmd
cd 00-开发环境搭建\scripts
check-java-windows.bat
```

**Linux/macOS:**
```bash
cd 00-开发环境搭建/scripts
chmod +x check-java-unix.sh
./check-java-unix.sh
```

### 手动验证

```bash
# 检查 Java 版本
java -version

# 检查编译器版本
javac -version

# 检查 JAVA_HOME
echo $JAVA_HOME          # Linux/macOS
echo %JAVA_HOME%         # Windows

# 检查 Java 位置
which java              # Linux/macOS
where java              # Windows
```

### 测试编译和运行

创建测试文件 `HelloWorld.java`:

```java
public class HelloWorld {
    public static void main(String[] args) {
        System.out.println("Hello, Java World!");
        System.out.println("Java Version: " + System.getProperty("java.version"));
    }
}
```

编译并运行:
```bash
javac HelloWorld.java
java HelloWorld
```

预期输出:
```
Hello, Java World!
Java Version: 17.0.x
```

---

## 多版本 Java 管理

### Windows

**使用 Java 版本切换器:**
```cmd
# 查看已安装版本
dir "C:\Program Files\Java"

# 临时切换
set PATH=C:\Program Files\Java\jdk-11\bin;%PATH%

# 永久切换需要修改 JAVA_HOME 环境变量
```

### Linux/macOS

**使用 update-alternatives (Ubuntu/Debian):**
```bash
# 查看已安装版本
sudo update-alternatives --config java

# 切换版本
sudo update-alternatives --config java
sudo update-alternatives --config javac
```

**使用 SDKMAN!（推荐）:**
```bash
# 安装 SDKMAN!
curl -s "https://get.sdkman.io" | bash

# 列出已安装版本
sdk list java | grep installed

# 安装多个版本
sdk install java 11.0.21-tem
sdk install java 17.0.9-tem
sdk install java 21.0.1-tem

# 切换默认版本
sdk default java 17.0.9-tem

# 临时切换当前会话
sdk use java 11.0.21-tem
```

**使用 jenv（macOS/Linux）:**
```bash
# 安装 jenv
brew install jenv

# 配置 jenv
echo 'export PATH="$HOME/.jenv/bin:$PATH"' >> ~/.zshrc
echo 'eval "$(jenv init -)"' >> ~/.zshrc
source ~/.zshrc

# 添加 Java 版本
jenv add /Library/Java/JavaVirtualMachines/openjdk-17.jdk/Contents/Home
jenv add /Library/Java/JavaVirtualMachines/openjdk-11.jdk/Contents/Home

# 列出已管理版本
jenv versions

# 设置全局版本
jenv global 17

# 设置当前目录版本
jenv local 11
```

---

## 常见问题

### Q1: 命令行提示"java 不是内部或外部命令"

**解决方案:**
1. 确认已安装 JDK
2. 检查 JAVA_HOME 环境变量是否正确设置
3. 检查 PATH 是否包含 `%JAVA_HOME%\bin`
4. 重启命令行窗口使环境变量生效

### Q2: 安装了多个 Java 版本，但使用的不是期望的版本

**解决方案:**

**Windows:**
```cmd
# 查看当前版本
java -version
where java

# 修改 JAVA_HOME 指向需要的版本
setx JAVA_HOME "C:\Program Files\Java\jdk-17" /M
```

**Linux:**
```bash
# 使用 update-alternatives
sudo update-alternatives --config java

# 或使用 SDKMAN
sdk default java 17.0.9-tem
```

### Q3: JAVA_HOME 设置后仍然无效

**解决方案:**

1. 确认路径正确（不要包含 bin 目录）
   ```
   正确: C:\Program Files\Java\jdk-17
   错误: C:\Program Files\Java\jdk-17\bin
   ```

2. 重启终端或注销后重新登录

3. Windows 下检查是否设置的是系统变量（不是用户变量）

### Q4: IntelliJ IDEA 无法识别 JDK

**解决方案:**

1. **File → Project Structure → SDKs**
2. 点击 + 号添加 JDK
3. 浏览到 JAVA_HOME 目录
4. 应用设置

### Q5: Maven/Gradle 无法找到 Java

**解决方案:**

```bash
# 验证 JAVA_HOME
echo $JAVA_HOME

# 验证 Java 可执行
$JAVA_HOME/bin/java -version

# 如果问题依旧，在 Maven 配置中指定 Java
export JAVA_HOME=/path/to/jdk
```

### Q6: 权限错误（Linux/macOS）

```bash
# 确保正确的权限
sudo chmod -R 755 /usr/lib/jvm/java-17-openjdk

# 如果是手动安装的 JDK
sudo chown -R root:root /opt/java
```

---

## 卸载 Java

### Windows

```cmd
# 控制面板 → 程序和功能 → 卸载 Java

# 或使用命令行
wmic product where "name like '%%Java%%'" call uninstall

# 使用 Chocolatey
choco uninstall openjdk17
```

### Linux

```bash
# Ubuntu/Debian
sudo apt remove openjdk-17-jdk
sudo apt autoremove

# CentOS/RHEL
sudo yum remove java-17-openjdk-devel
```

### macOS

```bash
# 使用 Homebrew
brew uninstall openjdk@17

# 手动删除
sudo rm -rf /Library/Java/JavaVirtualMachines/openjdk-17.jdk
```

---

## 参考资源

### 官方网站

- [Oracle JDK](https://www.oracle.com/java/technologies/downloads/)
- [OpenJDK](https://openjdk.org/)
- [Adoptium (Eclipse Temurin)](https://adoptium.net/)
- [Amazon Corretto](https://aws.amazon.com/corretto/)
- [Azul Zulu](https://www.azul.com/downloads/)

### 文档

- [Java 官方文档](https://docs.oracle.com/en/java/)
- [OpenJDK 文档](https://openjdk.org/projects/)
- [Java 版本历史](https://en.wikipedia.org/wiki/Java_version_history)

### 工具

- [SDKMAN!](https://sdkman.io/) - Java 版本管理工具
- [jEnv](https://www.jenv.be/) - Java 环境管理
- [Chocolatey](https://chocolatey.org/) - Windows 包管理器
- [Homebrew](https://brew.sh/) - macOS/Linux 包管理器

---

## 下一步

安装完 Java 后，建议继续配置：

1. [ ] 安装 IDE（IntelliJ IDEA 或 Eclipse）
2. [ ] 安装构建工具（Maven 或 Gradle）
3. [ ] 配置 Git 版本控制
4. [ ] 安装其他开发工具

返回 [主目录](../README.md) 查看完整学习路径。
