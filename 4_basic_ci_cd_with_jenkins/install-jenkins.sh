#!/bin/bash

echo "* Install Jenkins ..."
sudo wget https://pkg.jenkins.io/redhat/jenkins.repo -O /etc/yum.repos.d/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat/jenkins.io.key

sudo dnf makecache

sudo yum -y install jenkins 

echo "* Install Java 17 ..."
sudo yum -y install java-17-openjdk
echo "* Start Jenkins ..."

sudo systemctl enable jenkins
sudo systemctl start jenkins

echo "* Add vagrant user to jenkins group ..."
usermod -aG jenkins vagrant