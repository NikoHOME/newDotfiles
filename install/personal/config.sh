#!/bin/sh

#personal config installtion script


SCRIPT=$(realpath "$0")
SCRIPTPATH=$(dirname "$SCRIPT")

sudo localectl --no-convert set-x11-keymap pl
default-web-browser firefox.desktop

#password unlimited retries
sudo cp -rf $SCRIPTPATH/../../misc/faillock.conf /etc/security/faillock.conf
