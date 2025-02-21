#!/bin/bash

# 打印开始信息
echo "开始安装依赖和 Nexus 脚本..."

# 安装必要的系统依赖（包括 OpenSSL 和 pkg-config）
echo "正在安装必要的系统依赖..."
sudo apt update
sudo apt install -y libssl-dev pkg-config

# 安装最新版 Protocol Buffers
echo "正在安装最新版 protobuf..."
sudo apt remove -y protobuf-compiler  # 移除可能的旧版本
wget https://github.com/protocolbuffers/protobuf/releases/download/v25.3/protoc-25.3-linux-x86_64.zip
unzip protoc-25.3-linux-x86_64.zip -d /usr/local
sudo ln -sf /usr/local/bin/protoc /usr/bin/protoc
protoc --version  # 验证安装

# 重启受影响的关键服务
echo "正在重启受影响的服务..."
sudo systemctl restart ssh.service
sudo systemctl restart systemd-journald.service
sudo systemctl restart systemd-logind.service
sudo systemctl restart systemd-resolved.service
sudo systemctl restart systemd-timesyncd.service

# 安装 Rust
echo "正在安装 Rust..."
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
# source cargo 环境变量
source "$HOME/.cargo/env"
# 添加 riscv32i target
rustup target add riscv32i-unknown-none-elf

# 请求用户输入Node ID并保存
echo "请输入Node ID："
read NODE_ID
mkdir -p ~/.nexus
echo "$NODE_ID" > ~/.nexus/node-id

# 安装 Nexus 脚本
echo "正在安装 Nexus 脚本..."
curl https://cli.nexus.xyz | sh

echo "安装完成！请按照提示继续配置节点 ID"

# 保持终端打开，让用户可以继续输入节点 ID
exec $SHELL
