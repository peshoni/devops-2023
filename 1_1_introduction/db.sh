#!/bin/bash

echo "* Add hosts ..."
echo "192.168.89.100 web.do2.lab web" >> /etc/hosts
echo "192.168.89.101 db.do2.lab db" >> /etc/hosts

echo "* Install Software ..."
#dnf upgrade -y
dnf install -y mariadb mariadb-server git

echo "* Start HTTP ..."
systemctl enable mariadb
systemctl start mariadb

echo "* Stop firewall ..."
systemctl stop firewalld
systemctl disable firewalld

mkdir temp
echo "* Clone site content from git repo"
git clone https://github.com/shekeriev/bgapp temp
echo "*Clone is successfull" 
echo temp
cp -v temp/db/* /vagrant
rm -rf temp

echo "* Create and load the database ..."

mysql -u root < /vagrant/db_setup.sql
echo "* The schema was created..."
