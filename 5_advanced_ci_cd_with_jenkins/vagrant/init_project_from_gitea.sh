#!/bin/bash

sudo mkdir -p /projects
sudo chown -R jenkins:jenkins /projects
cd /projects
if [ -d /projects/bg-app ]; then
    cd bg-app
    git pull http://192.168.99.102:3000/pesho02/bg-app.git
else
    git clone http://192.168.99.102:3000/pesho02/bg-app.git
fi
