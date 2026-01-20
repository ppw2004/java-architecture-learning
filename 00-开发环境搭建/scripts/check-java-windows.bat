@echo off
REM ============================================
REM Java 环境检测脚本 (Windows)
REM 用途: 检测系统中是否安装了 Java 及其版本信息
REM ============================================

echo ========================================
echo       Java 环境检测工具 (Windows)
echo ========================================
echo.

REM 设置颜色代码
set "GREEN=[92m"
set "RED=[91m"
set "YELLOW=[93m"
set "RESET=[0m"

REM 检测 java 命令
echo [1/5] 检测 Java 命令...
where java >nul 2>&1
if %errorlevel% equ 0 (
    echo %GREEN%√%RESET% Java 命令已找到
) else (
    echo %RED%×%RESET% 未找到 Java 命令
    echo.
    echo 请先安装 JDK 或配置 JAVA_HOME 环境变量
    pause
    exit /b 1
)
echo.

REM 获取 Java 版本
echo [2/5] 检测 Java 版本信息...
for /f "tokens=3" %%i in ('java -version 2^>^&1 ^| findstr /i "version"') do (
    set "JAVA_VERSION=%%i"
    goto :version_found
)
:version_found
echo %GREEN%Java 版本:%RESET% %JAVA_VERSION%
echo.

REM 获取 Java 详细信息
echo [3/5] 获取 Java 详细信息...
java -version 2>&1 | findstr /V "Error"
echo.

REM 检查 JAVA_HOME 环境变量
echo [4/5] 检查 JAVA_HOME 环境变量...
if "%JAVA_HOME%"=="" (
    echo %YELLOW%⚠%RESET% JAVA_HOME 环境变量未设置
    echo 建议设置 JAVA_HOME 指向 JDK 安装目录
) else (
    echo %GREEN%√%RESET% JAVA_HOME: %JAVA_HOME%

    REM 验证 JAVA_HOME 下的 java.exe
    if exist "%JAVA_HOME%\bin\java.exe" (
        echo %GREEN%√%RESET% java.exe 存在于 %%JAVA_HOME%%\bin\
    ) else (
        echo %RED%×%RESET% 在 %%JAVA_HOME%%\bin\ 下未找到 java.exe
    )
)
echo.

REM 检查 javac 编译器
echo [5/5] 检查 Java 编译器 (javac)...
where javac >nul 2>&1
if %errorlevel% equ 0 (
    echo %GREEN%√%RESET% javac 命令已找到

    REM 获取 javac 版本
    for /f "tokens=3" %%i in ('javac -version 2^>^&1') do (
        set "JAVAC_VERSION=%%i"
    )
    echo javac 版本: %JAVAC_VERSION%
) else (
    echo %YELLOW%⚠%RESET% 未找到 javac 命令
    echo 可能只安装了 JRE，建议安装完整 JDK
)
echo.

REM 显示完整路径
echo ========================================
echo Java 安装路径信息
echo ========================================
where java 2>nul
where javac 2>nul
echo.

REM 环境检查总结
echo ========================================
echo 环境检查总结
echo ========================================
if "%JAVA_HOME%"=="" (
    echo %YELLOW%⚠%RESET% 建议: 配置 JAVA_HOME 环境变量
)
where javac >nul 2>&1
if %errorlevel% neq 0 (
    echo %YELLOW%⚠%RESET% 建议: 安装完整 JDK (包含 javac 编译器)
)
echo.

echo 检测完成！
echo.
pause
