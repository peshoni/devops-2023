#!/bin/bash

# directory for the keyring
sudo mkdir /etc/apt/keyrings
sudo curl -fsSL -o /etc/apt/keyrings/salt-archive-keyring.gpg https://repo.saltproject.io/salt/py3/debian/11/amd64/latest/SALT-PROJECT-GPG-PUBKEY-2023.gpg

echo "deb [signed-by=/etc/apt/keyrings/salt-archive-keyring.gpg arch=amd64] https://repo.saltproject.io/salt/py3/debian/11/amd64/latest bullseye main" | sudo tee /etc/apt/sources.list.d/salt.list

sudo apt-get update
sudo apt-get install -y salt-minion

# sudo vi /etc/salt/minion

sudo sed -i "s%#master: salt%master: server%g" "/etc/salt/minion"

sudo systemctl restart salt-minion
