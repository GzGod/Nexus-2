#!/bin/bash

# 打印开始信息
echo "开始安装依赖和 Nexus 脚本..."

# 安装 protobuf
echo "正在安装 protobuf..."
sudo apt update
sudo apt install -y protobuf-compiler

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
echo "$PROVER_ID" > ~/.nexus/node-id

# 安装 Nexus 脚本
echo "正在安装 Nexus 脚本..."
curl https://cli.nexus.xyz | sh

echo "安装完成！请按照提示继续配置节点 ID"

# 保持终端打开，让用户可以继续输入节点 ID
exec $SHELL
