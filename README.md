# docker-on-demand

    docker run -ti -p 20022:22 --privileged noisy/docker-on-demand

  Type:

    ssh root@localhost -p 20022
    #password: docker

  Each time when you will login via ssh, you will start and login directly to fresh container of docker inside docker-on-demand container, which is capable of running next docker containers :)
  
![Diagram](http://i.imgur.com/nt3f5ds.png "Diagram")
  
  
# This is madness!

No, this is... optimization. To be precize, bandwidth optimization in case when you are asking 30 people during docker workshops to pull some images :)
