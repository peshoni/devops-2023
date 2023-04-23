#!/bin/bash

sudo rpm --import https://repo.saltproject.io/salt/py3/redhat/9/x86_64/SALT-PROJECT-GPG-PUBKEY-2023.pub
curl -fsSL https://repo.saltproject.io/salt/py3/redhat/9/x86_64/latest.repo | sudo tee /etc/yum.repos.d/salt.repo
sudo yum clean expire-cache
sudo yum install -y salt-minion
# change in file master: server

sudo sed -i "s%#master: salt%master: server%g" "/etc/salt/minion"

sudo systemctl restart salt-minion
