#!/bin/bash

MAIN_URL=dhod.pl

source ./env/list
docker run -ti -p 20022:22 -p 80 -e VIRTUAL_HOST=*.$MAIN_URL -e MAIN_URL=$MAIN_URL --privileged --env-file=./env/list -v /home/dond/docker-on-demand/env/:/env/ quay.io/noisy/dockerhost-on-demand-provider
