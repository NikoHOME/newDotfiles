#!/bin/sh

#personal config installtion script

#keymap
localectl --no-convert set-x11-keymap pl

#password unlimited retries
sudo cp -rf ../../misc/faillock.conf /etc/security/faillock.conf