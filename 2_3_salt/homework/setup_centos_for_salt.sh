#!/bin/bash

# sudo rpm --import https://repo.saltproject.io/salt/py3/redhat/9/x86_64/latest/SALTSTACK-GPG-KEY2.pub
sudo rpm --import https://repo.saltproject.io/salt/py3/redhat/9/x86_64/latest/SALT-PROJECT-GPG-PUBKEY-2023.pub

curl -fsSL https://repo.saltproject.io/salt/py3/redhat/9/x86_64/latest.repo | sudo tee /etc/yum.repos.d/salt.repo

sudo dnf -y install salt-ssh

# masters and minions

wget -O bootstrap-salt.sh https://bootstrap.saltstack.com

#Install the latest stable version – just the master (-M), without the minion (-N) part, do not start the daemons (-X):
# sudo sh bootstrap-salt.sh -M -N -X

sudo yum -y install salt-master

sudo firewall-cmd --permanent --add-port=4505-4506/tcp
sudo firewall-cmd --reload

sudo cp -f /vagrant/roster /etc/salt/roster

# It is time to enable, start the Salt master service, and check if everything is okay
sudo systemctl enable salt-master
sudo systemctl start salt-master
# sudo systemctl enable salt-master && sudo systemctl start salt-master
# systemctl status salt-master
