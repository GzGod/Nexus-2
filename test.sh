#!/bin/bash

# Install Rust and rustup, automatically selecting option 1
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

# Add the RISC-V target
rustup target add riscv32i-unknown-none-elf

# Install Nexus CLI
curl https://cli.nexus.xyz/ | sh
