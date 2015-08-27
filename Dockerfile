FROM jpetazzo/dind

RUN apt-get update && apt-get install -y openssh-server
RUN mkdir /var/run/sshd

RUN useradd -m -g docker -p U6aMy0wojraho docker
RUN echo "new ALL=(ALL) NOPASSWD: /usr/sbin/useradd" >> /etc/sudoers

ADD sshd_config /etc/ssh/sshd_config
ADD entrypoint.sh /entrypoint.sh
ADD post_login.sh /post_login.sh

ENTRYPOINT /entrypoint.sh


