#!/bin/bash

#  Download the package
wget -P /tmp https://packages.chef.io/files/stable/chef-server/15.6.2/el/8/chef-server-core-15.6.2-1.el8.x86_64.rpm
# Install the package
sudo rpm -Uvh /tmp/chef-server-core-15.6.2-1.el8.x86_64.rpm

sudo firewall-cmd --add-port=80/tcp --permanent
sudo firewall-cmd --add-port=443/tcp --permanent
sudo firewall-cmd --reload
