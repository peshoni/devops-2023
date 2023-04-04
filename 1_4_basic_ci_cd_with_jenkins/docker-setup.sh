#!/bin/bash

echo "* Add Docker repository ..."
dnf config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo

echo "* Install Docker, Git and apache ..."
dnf install -y docker-ce docker-ce-cli containerd.io httpd
sudo yum -y install git

echo "* Enable and start Docker ..."
systemctl enable docker
systemctl start docker

echo "* Add vagrant user to docker group ..."
usermod -aG docker vagrant
echo "* Add jenkins user to docker group ..."
usermod -aG docker jenkins

# sudo systemctl restart jenkins
