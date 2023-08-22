#!/bin/sh

FILE=$1
if [ -f "$FILE" ]; then
    printf "\n<==[::]==> Build finished\n\n"
else
    printf "\n<==[%%]==> Build failed\n\n"
    exit 3
fi
