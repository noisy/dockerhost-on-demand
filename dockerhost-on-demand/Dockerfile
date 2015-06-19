FROM jpetazzo/dind

RUN apt-get update && \
    apt-get install -y vim nano mc

ADD materialy/ /materialy/
ADD .bash* /root/
ADD boot.msg /etc/motd
