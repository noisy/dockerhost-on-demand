#!/bin/bash

export TERM=xterm

while true
do
	clear

	echo -e Active: `docker ps | grep "quay.io/noisy/dockerhost-on-demand" | awk '{print $NF}' | wc -l`
	docker ps | grep "quay.io/noisy/dockerhost-on-demand" | awk '{print $NF}' | xargs -i echo "  {}"

	echo ""

	echo -e Exited: `docker ps -a -f status=exited | grep "quay.io/noisy/dockerhost-on-demand" | awk '{print $NF}' | wc -l`
	docker ps -a -f status=exited | grep "quay.io/noisy/dockerhost-on-demand" | awk '{print $NF}' | xargs -i echo "  {}"


	sleep 1;
done
