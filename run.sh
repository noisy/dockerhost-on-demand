#!/bin/bash

/etc/init.d/ssh start 
docker run -d -p 80:80 -v /var/run/docker.sock:/tmp/docker.sock jwilder/nginx-proxy
/username_factory.sh&
/usr/local/bin/wrapdocker /bin/zsh
