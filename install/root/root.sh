#!/bin/sh

#root configuratrion script

SCRIPT=$(realpath "$0")
SCRIPTPATH=$(dirname "$SCRIPT")

#refind bootloader theme
sudo cp -rf $SCRIPTPATH/../../refind/* /boot/EFI/refind/
#lighdm greeter
sudo cp -rf $SCRIPTPATH/../../lightdm/* /etc/lightdm/

sudo refind-install
