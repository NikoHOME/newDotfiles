#!/bin/sh

#config files copy script 


SCRIPT=$(realpath "$0")
SCRIPTPATH=$(dirname "$SCRIPT")

cp -rf $SCRIPTPATH/../../config/* ~/.config
cp -rf $SCRIPTPATH/../../local/*  ~/.local/share/omf/themes/slacker/fish_prompt.fish