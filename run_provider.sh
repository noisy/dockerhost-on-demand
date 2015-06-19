#!/bin/bash


docker run -ti -p 22:22 -p 80 --privileged -v /home/dkr/dockerhost-on-demand/env/:/env/ quay.io/noisy/dockerhost-on-demand-provider
