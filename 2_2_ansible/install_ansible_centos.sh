#!/bin/bash

dnf install -y ansible-core
dnf install -y python-setuptools

ansible-galaxy collection install -p /usr/share/ansible/collections ansible.posix
ansible-galaxy collection install community.docker
ansible-galaxy collection install community.mysql
