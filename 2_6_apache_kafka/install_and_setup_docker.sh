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
