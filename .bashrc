read id < /tmp/get_uniq

source /env/list
HOST_URL=host${id}.backup.dhod.pl

exec docker run --privileged -t -i -e LOG=file -e VIRTUAL_HOST=$HOST_URL -e HOST_URL=$HOST_URL -p 80 quay.io/noisy/dockerhost-on-demand:infobackup

