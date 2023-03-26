#!/bin/bash

echo "* Add Docker repository"
dnf config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo

echo "* Install Docker"
dnf install -y java-17-openjdk docker-ce docker-ce-cli containerd.io git # java is for node exporter

echo "* Start Docker service"
systemctl enable --now docker

echo "* Adjust group membership"
usermod -aG docker vagrant

echo "* Adjust the firewall"
firewall-cmd --add-port 8080/tcp --permanent
firewall-cmd --reload

sudo useradd jenkins
#Add the jenkins user to the docker group
sudo usermod -aG docker jenkins
