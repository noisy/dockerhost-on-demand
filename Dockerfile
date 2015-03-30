FROM jpetazzo/dind

RUN apt-get update && apt-get install -y openssh-server zsh
RUN mkdir /var/run/sshd
RUN echo 'root:docker' | chpasswd
RUN sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile
RUN echo "docker pull noisy/dockerhost-on-demand" >> /root/.zshrc

ADD get_ports.py get_ports.py
ADD get_options.sh get_options.sh
RUN chmod +x /get_options.sh

RUN echo "exec docker run --privileged -t -i -e LOG=file \`/get_options.sh\` noisy/dockerhost-on-demand" >> /root/.bashrc
ADD run.sh run.sh

EXPOSE 22
CMD ["/run.sh"]
