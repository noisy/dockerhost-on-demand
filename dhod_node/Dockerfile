FROM jpetazzo/dind

RUN apt-get update && \
    apt-get install -y vim nano mc python-pip zsh

RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

RUN pip install docker-compose

WORKDIR /root/
ADD tutorial/ /root/tutorial/

ADD .bash* /root/
ADD boot.msg /etc/motd

RUN chsh -s /usr/bin/zsh root
RUN echo "exec asciinema rec /asciinema/$VIRTUAL_HOST -w 3 -y -c /bin/bash" > /root/.zshrc
