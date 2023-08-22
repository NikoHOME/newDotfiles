#!/bin/sh

#root configuratrion script

#refind bootloader theme
sudo cp -rf ../../refind/* /boot/EFI/refind/
#lighdm greeter
sudo cp -rf ../../lightdm/* /etc/lightdm/

sudo refind-install
