#!/bin/sh

#nvim theme installation script
#https://github.com/NvChad/NvChad 



DIR=~/.config/nvim
if [ -d "$DIR" ]; then
    printf "\n<==[::]==> Build skipped $DIR already exists\n\n"
    exit 0
fi

git clone https://github.com/NvChad/NvChad ~/.config/nvim --depth 1