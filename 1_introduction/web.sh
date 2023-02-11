#!/bin/bash

echo "* Add hosts ..."
echo "192.168.89.100 web.do2.lab web" >> /etc/hosts
echo "192.168.89.101 db.do2.lab db" >> /etc/hosts

echo "* Install Software ..."
#dnf upgrade -y
dnf install -y httpd php php-mysqlnd git

echo "* Start HTTP ..."
systemctl enable httpd
systemctl start httpd

echo "* Stop firewall ..."
systemctl stop firewalld
systemctl disable firewalld
 
mkdir temp
echo "* Clone site content from git repo"
git clone https://github.com/shekeriev/bgapp temp
echo "*Clone is successfull" 
echo temp
cp -v temp/web/* /vagrant 
rm -rf temp

echo "* Copy web site files to /var/www/html/ ..."
cp /vagrant/* /var/www/html

echo "* Allow HTTPD to make network connections ..."
setsebool -P httpd_can_network_connect=1
