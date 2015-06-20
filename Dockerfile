FROM jpetazzo/dind

RUN apt-get update && apt-get install -y openssh-server zsh
RUN mkdir /var/run/sshd
RUN echo 'root:docker' | chpasswd
RUN sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile
RUN echo "docker pull quay.io/noisy/dockerhost-on-demand:infomeet" >> /root/.zshrc
RUN echo "docker pull jwilder/nginx-proxy" >> /root/.zshrc
RUN echo "docker run -d -p 80:80 -v /var/run/docker.sock:/tmp/docker.sock jwilder/nginx-proxy" >> /run_proxy.sh

RUN touch /tmp/test_touch

ADD get_ports.py get_ports.py
ADD get_options.sh get_options.sh
ADD username_factory.sh username_factory.sh
ADD .bashrc /tmp/.bashrc
RUN chmod +x /get_options.sh
RUN chmod +x /username_factory.sh

RUN cat /tmp/.bashrc >> /root/.bashrc
RUN apt-get install -y vim
ADD run.sh run.sh

EXPOSE 22
CMD ["/run.sh"]
