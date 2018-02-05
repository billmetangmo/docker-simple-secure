#!/bin/bash
set -e

echo "<<< Disable docker  SElinux >>>"
semodule -v -d docker

echo "<<< Erasing docker rpm ... >>>"
yum -y remove docker-engine docker-engine-selinux


## avoid error : rm: cannot remove ‘/var/run/docker/netns/default’: Device or resource busy - docker 17.05 ###
umount /var/run/docker/netns/default
rm -rf /var/lib/docker
rm -rf /var/run/docker
