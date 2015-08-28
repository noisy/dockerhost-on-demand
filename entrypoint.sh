#!/bin/bash

sed -i "s/<MAIN_DOMAIN>/$MAIN_DOMAIN/" /post_login.sh

service ssh start

/usr/local/bin/wrapdocker &> /var/log/docker.log &

tail -f /var/log/docker.log | while read LOGLINE
do
   [[ "${LOGLINE}" == *"Daemon has completed initialization"* ]] && pkill -P $$ tail
done

#------------------------------------------------------------------------------
if [ $(docker ps -a | awk '{print $(NF)}' | grep "registry" | wc -l) -eq 1 ]
then
    docker rm registry
fi

if [ $(docker ps -a | awk '{print $(NF)}' | grep "nginx-proxy" | wc -l) -eq 1 ]
then
    docker rm nginx-proxy
fi

if [ $(docker ps -a | awk '{print $(NF)}' | grep "wetty" | wc -l) -eq 1 ]
then
    docker rm wetty
fi

#------------------------------------------------------------------------------
docker run -d \
    -p 5000:5000 \
    -e STANDALONE=false \
    -e MIRROR_SOURCE=https://registry-1.docker.io \
    -e MIRROR_SOURCE_INDEX=https://index.docker.io \
    -v /tmp/registry:/tmp/registry \
    --name registry \
    registry

docker run -d \
    -p 80:80 \
    -v /var/run/docker.sock:/tmp/docker.sock:ro \
    --name nginx-proxy \
    jwilder/nginx-proxy

docker run -d \
    --name wetty \
    -e VIRTUAL_HOST=$MAIN_DOMAIN \
    -p 80 \
    noisy/wetty \
    app.js -p 80 --sshuser docker --sshhost 10.0.42.1

docker pull noisy/dhod_node
#------------------------------------------------------------------------------

tail -f /var/log/docker.log
