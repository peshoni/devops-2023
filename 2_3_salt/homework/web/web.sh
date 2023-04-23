#!/bin/bash

apt-get install -y php php-mysqlnd

sudo rm -r /var/www/html/*
cp /vagrant/app/* /var/www/html

setsebool -P httpd_can_network_connect=1

systemctl restart httpd
