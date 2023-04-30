#!/bin/bash

sudo dnf install -y chrony
sudo systemctl enable chronyd
sudo systemctl start chronyd

# Set SELinux to permissive mode for the current session
sudo setenforce permissive

# And for the next boot
sudo sed -i 's\=enforcing\=permissive\g' /etc/sysconfig/selinux
