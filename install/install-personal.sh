#!/bin/sh

#personal install script

SCRIPT=$(realpath "$0")
SCRIPTPATH=$(dirname "$SCRIPT")

cd $SCRIPTPATH

for x in personal/*
do
    printf "\n<==[::]==> $x Starts\n\n"
    eval $x
    return_code=$?
    if [ $return_code = "0" ]; then
        printf "\n<==[::]==> Success\n\n"
    else
        printf "\n<==[::]==> Fail\n\n"
        exit 1
    fi
done