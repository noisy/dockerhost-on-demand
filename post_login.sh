#!/usr/bin/env bash

MAIN_DOMAIN="<MAIN_DOMAIN>"

timestamp () {
  date +"%Y-%m-%d_%H-%M-%S";
};

if [ "`whoami`" = "docker" ]; then

  hostname=""
  while [[ ! $hostname =~ ^[a-z0-9]+$ ]]; do
    echo -n "hostname [a-z0-9]: "
    read hostname
  done

  HOST_URL=$hostname.$MAIN_DOMAIN

  if [ $(docker ps -a | tail -n +2 | awk '{print $(NF)}' | grep -Fx "$hostname" | wc -l) -eq 0 ]; then

      docker run \
             --privileged \
             --name $hostname \
             -d \
             -t \
             -i \
             --link registry:registry \
             -e LOG=file \
             -e VIRTUAL_HOST=$HOST_URL \
             -e HOST_URL=$HOST_URL \
             -e DOCKER_DAEMON_ARGS=--registry-mirror=http://registry:5000 \
             -p 80 quay.io/noisy/dockerhost-on-demand:infomeet

  elif [ $(docker ps -a -f status=exited | awk '{print $(NF)}' | grep -Fx "$hostname" | wc -l) -eq 1 ]; then
       docker start $hostname
  fi

  exec asciinema rec /asciinema/$hostname_`timestamp`.rec -w 3 -y -c 'docker exec -ti $hostname bash'

else
  /bin/bash
fi
