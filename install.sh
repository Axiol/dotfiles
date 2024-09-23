#!/bin/bash

printf "Installing dependencies...\n"
sudo apt-get install -y ripgrep

printf "Copying files...\n"
ln -s .config/bash/.bashrc .bashrc
