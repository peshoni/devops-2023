#!/bin/bash

# wget -O bootstrap-salt.sh https://bootstrap.saltstack.com
# sudo sh bootstrap-salt.sh

# CENTOS
sudo rpm --import https://repo.saltproject.io/salt/py3/redhat/9/x86_64/SALT-PROJECT-GPG-PUBKEY-2023.pub
curl -fsSL https://repo.saltproject.io/salt/py3/redhat/9/x86_64/latest.repo | sudo tee /etc/yum.repos.d/salt.repo
sudo yum clean expire-cache
sudo yum install -y salt-minion
# change in file master: sertver
sudo systemctl restart salt-minion

# DEBIAN
# directory for the keyring
sudo mkdir /etc/apt/keyrings
sudo curl -fsSL -o /etc/apt/keyrings/salt-archive-keyring.gpg https://repo.saltproject.io/salt/py3/debian/11/amd64/latest/SALT-PROJECT-GPG-PUBKEY-2023.gpg

echo "deb [signed-by=/etc/apt/keyrings/salt-archive-keyring.gpg arch=amd64] https://repo.saltproject.io/salt/py3/debian/11/amd64/latest bullseye main" | sudo tee /etc/apt/sources.list.d/salt.list

sudo apt-get update
sudo apt-get install -y salt-minion

# sudo vi /etc/salt/minion
sudo systemctl restart salt-minion
