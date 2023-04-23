#!/bin/bash

dnf install -y python3 python3-pip python3-distro

sudo rpm --import https://repo.saltproject.io/salt/py3/redhat/9/x86_64/latest/SALT-PROJECT-GPG-PUBKEY-2023.pub

curl -fsSL https://repo.saltproject.io/salt/py3/redhat/9/x86_64/latest.repo | sudo tee /etc/yum.repos.d/salt.repo

sudo dnf -y install salt-ssh

sudo cp -f /vagrant/roster /etc/salt/roster
