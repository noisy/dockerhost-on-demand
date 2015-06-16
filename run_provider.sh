#!/bin/bash

DKR_ARGS=""

source ./env/list

for host_number in $(seq 1 $MAX_HOSTS);
do
    for port_number in $(seq 0 $PORTS_PER_HOST);
    do
        port=`printf "2%02d%02d" $host_number $port_number`
        DKR_ARGS="$DKR_ARGS -p $port:$port"
    done
done

#docker run -ti -p 20022:22 -p 80 -e VIRTUAL_HOST=*.dhod --privileged --env-file=./env/list -v /home/dond/docker-on-demand/env/:/env/ $DKR_ARGS noisy/dockerhost-on-demand-provider
docker run -ti -p 20022:22 -p 80 -e VIRTUAL_HOST=*.dhod --privileged --env-file=./env/list -v /home/dond/docker-on-demand/env/:/env/ noisy/dockerhost-on-demand-provider
