#!/bin/bash
set -e

#echo "you passed me" $@
privileged_flag=0

### TODO: arg --user root{uid} could be a simple attack https://docs.docker.com/engine/reference/run/#user ###
### --security-opt: https://docs.docker.com/engine/reference/run/#security-configuration 
### just let cap_net_raw https://docs.docker.com/engine/reference/run/#runtime-privilege-and-linux-capabilities
### read-only file system to avoid write on /proc/sys or infiniband devices write
### set default logging driver: https://docs.docker.com/engine/reference/run/#logging-drivers-log-driver
### TODO: instead of disbaling, allowing instead just commands 

for arg in "$@"
do
    if [[ $arg  == "--privileged" ]]
    then
        echo "you are not able to use the --privileged option"
        privileged_flag=1
        exit 1
    fi
done

if [[ $privileged_flag  == 0 ]]
then
    docker $@
fi

