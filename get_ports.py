import os
import urllib, json

url = 'http://zonza-swarm:4243/containers/json'
response = urllib.urlopen(url)
data = json.loads(response.read())

dond = [image for image in data if image['Image'] == u'noisy/dockerhost-on-demand-provider:latest'][0]

mapped_ports = {}

for port_pair in sorted(dond['Ports'], key=lambda x:x['PrivatePort']):

    if port_pair['PrivatePort'] > 8000:
        # print "{} {}".format(port_pair['PublicPort'], port_pair['PrivatePort'])
        mapped_ports[port_pair['PrivatePort']] = port_pair['PublicPort']


PORT_TMPL = '2{0:02d}{1:02d}'
max_hosts = int(os.environ['MAX_HOSTS'])
ports_per_host = int(os.environ['PORTS_PER_HOST'])

result = ""

for host_number in range(1, max_hosts+1):
    for port_number in range(1, ports_per_host+1):
        port = int(PORT_TMPL.format(host_number, port_number))
        result +='-p {}:{} '.format(port, port)
    
    result += "-e FIRSTPORT={} -e LASTPORT={} \n".format(
        PORT_TMPL.format(host_number, 1),
        PORT_TMPL.format(host_number, ports_per_host)
    )

print result
