#!/bin/bash
set -e

### To gracefully stop all containers before stopping the daemon ####
echo "<<< Stopping containers... >>>"
docker_ps=$(docker ps -a -q)
if [[ $docker_ps  != "" ]]
    then
        docker stop $docker_ps
    fi


echo "<<< Stopping docker... >>>"
systemctl stop docker

