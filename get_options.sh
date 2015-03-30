#!/bin/bash
EXISTING_DOCKER_HOSTS=`docker ps|grep noisy/dockerhost-on-demand:latest|wc -l`

DOCKER_HOST_NO=$((EXISTING_DOCKER_HOSTS+1))

PORTS=`python /get_ports.py |  sed $DOCKER_HOST_NO"q;d"`
HOSTNAME="--hostname=dockerhost-on-demand-$DOCKER_HOST_NO"
#NAME="--name dockerhost-on-demand-$DOCKER_HOST_NO"

echo $PORTS $HOSTNAME #$NAME
