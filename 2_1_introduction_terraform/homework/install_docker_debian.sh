#!/bin/bash

echo "* Add hosts ..."
echo "192.168.99.100 docker" >>/etc/hosts

echo "* Add any prerequisites ..."
apt-get update
apt-get install -y ca-certificates curl gnupg lsb-release

echo "* Add Docker repository and key ..."
curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list >/dev/null

echo "* Install Docker ..."
apt-get update
apt-get install -y docker-ce docker-ce-cli containerd.io git

echo "* Add vagrant user to docker group ..."
usermod -aG docker vagrant

echo "* Adjust Docker configuration ..."
sed -i 's@-H fd://@-H fd:// -H tcp://0.0.0.0@g' /lib/systemd/system/docker.service

echo "* Restart Docker ..."
systemctl daemon-reload
systemctl restart docker
