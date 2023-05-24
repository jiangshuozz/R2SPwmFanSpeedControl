#!/bin/bash

wget https://github.com/jiangshuozz/R2SPwmFanSpeedControl/archive/refs/heads/main.zip -O R2SPwmFanSpeedControl
if [ $? != 0 ];then
    echo "Download fail! PLease try again after 10 seconds!"
    exit $?
fi
unzip R2SPwmFanSpeedControl
pushd .
cd ./R2SPwmFanSpeedControl-main
sh ./one-key-deploy.sh

# clean env
rm -rf R2SPwmFanSpeedControl
rm -rf ./R2SPwmFanSpeedControl-main
popd