#!/bin/bash

printf "Installing dependencies...\n"
sudo apt-get install -y ripgrep less

printf "Copying files...\n"
ln -s .config/bash/.bashrc .bashrc
ln -s .config/zsh/.zshrc .zshrc
