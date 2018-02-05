#!/bin/bash
set -e

echo "<<< allowing docker to run with SeLinux... >>>"
docker_system_file=/usr/lib/systemd/system/docker.service 

## firstly, remove --selinux-enabled to make this operation idempotent
sed -i -e 's#--selinux-enabled##g' $docker_system_file
sed -i -e 's#ExecStart=/usr/bin/dockerd#ExecStart=/usr/bin/dockerd --selinux-enabled#g' $docker_system_file

echo "<<< starting docker process... >>>"
systemctl start docker


## To avoid issue: https://github.com/moby/moby/issues/30097
## this issue is corrected in docker-ce-17.06
systemctl stop docker

rm -rf /var/lib/docker
rm -rf /var/run/docker

chcon -t docker_exec_t /usr/bin/docker*
chcon -t docker_exec_t /usr/bin/docker_bin/*

echo "<<< Restarting docker process... >>>"
systemctl start docker
