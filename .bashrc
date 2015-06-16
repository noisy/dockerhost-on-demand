read id < /tmp/get_uniq
domain=host${id}.dhod

#exec docker run --privileged -t -i -e LOG=file -e VIRTUAL_HOST=$domain -h $domain -p 80 `/get_options.sh` noisy/dockerhost-on-demand
exec docker run --privileged -t -i -e LOG=file -e VIRTUAL_HOST=$domain -h $domain -p 80 noisy/dockerhost-on-demand

