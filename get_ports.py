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


INNER_PORT_TMPL = '80{}{}'
INNER_HOSTS = 3
INNER_PORTS = [0, 1, 2]

for inner_host in range(1, INNER_HOSTS+1):
    for inner_port in INNER_PORTS:
        port = int(INNER_PORT_TMPL.format(inner_host, inner_port))
        mapped = mapped_ports[port]
        print '-p {}:{} '.format(port, port),
    print ''
