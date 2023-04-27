#!/bin/bash

sudo dnf install -y chrony
sudo systemctl enable chronyd
sudo systemctl start chronyd

# Set SELinux to permissive mode for the current session
sudo setenforce permissive
# And for the next boot
sudo sed -i 's\=enforcing\=permissive\g' /etc/sysconfig/selinux

#  Download the package
wget -P /tmp https://packages.chef.io/files/stable/chef-server/15.6.2/el/8/chef-server-core-15.6.2-1.el8.x86_64.rpm
# Install the package
sudo rpm -Uvh /tmp/chef-server-core-15.6.2-1.el8.x86_64.rpm
