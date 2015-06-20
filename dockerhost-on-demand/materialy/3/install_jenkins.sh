#!/bin/bash

# install java 1.8.45
add-apt-repository ppa:webupd8team/java -y
apt-get update
apt-get install -y oracle-java8-installer oracle-java8-set-default

mkdir -p /var/jenkins_home
export JENKINS_HOME=/var/jenkins_home
useradd -d "$JENKINS_HOME" -u 1000 -m -s /bin/bash jenkins

apt-get install -y curl
curl -fL http://mirrors.jenkins-ci.org/war-stable/1.609.1/jenkins.war -o jenkins.war
