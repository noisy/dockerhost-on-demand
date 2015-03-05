FROM jpetazzo/dind

RUN apt-get update && apt-get install -y openssh-server zsh
RUN mkdir /var/run/sshd
RUN echo 'root:docker' | chpasswd
RUN sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile
RUN echo "docker pull jpetazzo/dind" >> /root/.zshrc
RUN echo "exec docker run --privileged -t -i -e LOG=file jpetazzo/dind" >> /root/.bashrc
ADD run.sh run.sh

EXPOSE 22
CMD ["/run.sh"]
