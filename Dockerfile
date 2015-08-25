FROM jpetazzo/dind

RUN apt-get update && apt-get install -y openssh-server
RUN mkdir /var/run/sshd
RUN echo 'root:docker' | chpasswd

ADD sshd_config /etc/ssh/sshd_config
ADD entrypoint.sh /entrypoint.sh

ENTRYPOINT /entrypoint.sh


