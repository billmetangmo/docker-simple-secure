#!/bin/bash
set -e

echo "<<< Installing docker... >>>"
yum -y install docker-engine

echo "<<< Activating selinux... >>>"
semodule -v -e docker

