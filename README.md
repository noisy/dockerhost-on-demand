# docker-on-demand

[![Join the chat at https://gitter.im/noisy/dockerhost-on-demand](https://badges.gitter.im/Join%20Chat.svg)](https://gitter.im/noisy/dockerhost-on-demand?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

[![nodesource/node](http://dockeri.co/image/noisy/docker-on-demand)](https://registry.hub.docker.com/u/noisy/docker-on-demand/)


    docker run -ti -p 20022:22 --privileged noisy/docker-on-demand

  Type:

    ssh root@localhost -p 20022
    #password: docker

  Each time when you will login via ssh, you will start and login directly to fresh container of docker inside docker-on-demand container, which is capable of running next docker containers :)
  
![Diagram](http://i.imgur.com/nt3f5ds.png "Diagram")
  
  
# This is madness!

No, this is... optimization. To be precize, bandwidth optimization in case when you are asking 30 people during docker workshops to pull some images :)
