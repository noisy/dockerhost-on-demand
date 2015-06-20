#!/bin/bash

MAIN_URL=dhod.pl
docker run -ti -p 22:22 -p 80 --env-file=./env/list -e VIRTUAL_HOST=*.$MAIN_URL -e MAIN_URL=$MAIN_URL --privileged -v `pwd`/env/:/env/ quay.io/noisy/dockerhost-on-demand-provider:infomeet
