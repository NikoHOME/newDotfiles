#!/bin/sh

#base install script


SCRIPT=$(realpath "$0")
SCRIPTPATH=$(dirname "$SCRIPT")

#packages

cd $SCRIPTPATH

eval apps/yay.sh

for x in packages/*
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

#apps


cd $SCRIPTPATH

for x in apps/*
do
    # cd $SCRIPTPATH/apps
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


#config

for x in config/*
do
    # cd $SCRIPTPATH/config
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

lxappearance &


