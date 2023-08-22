#!/bin/sh



DIR=$1

for x in "$DIR/*"
do
    echo $x
    eval $x
    return_code=$?
    if [ $return_code = "0" ]; then
        printf "\n<==[::]==> Success\n\n"
    else
        printf "\n<==[::]==> Fail\n\n"
        exit 1
    fi
done