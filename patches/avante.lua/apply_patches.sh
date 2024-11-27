#!/bin/bash

# Apply the custom Cargo.toml
cp /home/hummingbird108/.config/b9Joker108/my.neovim.config/patches/avante.lua/Cargo.toml.custom /home/hummingbird108/.local/share/b9Joker108/my.neovim.config/lazy/avante.nvim/Cargo.toml

# Apply the custom lib.rs
cp /home/hummingbird108/.config/b9Joker108/my.neovim.config/patches/avante.lua/lib.rs.custom /home/hummingbird108/.local/share/b9Joker108/my.neovim.config/lazy/avante.nvim/crates/avante-templates/src/lib.rs

# Rebuild the plugin
cd /home/hummingbird108/.local/share/b9Joker108/my.neovim.config/lazy/avante.nvim
cargo build --release
