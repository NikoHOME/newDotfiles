#!/bin/sh

DIALOG_RESULT=$(echo -e 'cancel\nexit bspwm\nreboot\nshutdown\nsleep' | rofi -dmenu -i -p "   Computer  " -hide-scrollbar -tokenize -lines 4 -eh 1 -width 40 -location 8 -xoffset 170 -yoffset 70 -padding 30 -disable-history -font "JetBrainsMono Nerd Font 18")

#echo "This result is : $DIALOG_RESULT"
sleep 0.5;

if [ "$DIALOG_RESULT" = "exit bspwm" ];
then
    exec kill bspwm
elif [ "$DIALOG_RESULT" = "reboot" ];
then
    exec reboot
elif [ "$DIALOG_RESULT" = "shutdown" ];
then
    exec shutdown -h now
elif [ "$DIALOG_RESULT" = "sleep" ];
then
    exec systemctl suspend
fi