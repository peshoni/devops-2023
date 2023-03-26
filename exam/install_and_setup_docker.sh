#!/bin/bash

# For Monitoring VM
echo "* Add Docker repository"
dnf config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo

echo "* Install Docker"
dnf install -y docker-ce docker-ce-cli containerd.io

echo "* Start Docker service"
systemctl enable --now docker

echo "* Adjust group membership"
usermod -aG docker vagrant

echo "* Adjust the firewall"
firewall-cmd --add-port 9090/tcp --permanent # prometheus
firewall-cmd --add-port 3000/tcp --permanent # grafana
firewall-cmd --reload

echo "* Change Docker configuration to expose Prometheus metrics"
cp /vagrant/daemon.json /etc/docker/

echo "* Restart Docker to apply the changes"
systemctl restart docker
