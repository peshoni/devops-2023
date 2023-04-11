#!/bin/bash

dnf install -y ansible-core
ansible-galaxy collection install -p /usr/share/ansible/collections ansible.posix
