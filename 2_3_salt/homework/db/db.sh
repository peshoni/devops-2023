#!/bin/bash
# sudo touch /etc/mysql/conf.d/bindaddress.cnf
sudo mkdir -p /etc/mysql/conf.d
sudo chown -R vagrant:vagrant /etc/mysql/conf.d
sudo echo "[mysqld] \n bind-address = 0.0.0.0" >>/etc/mysql/conf.d/bindaddress.cnf
sudo service mysqld start

systemctl stop firewalld
systemctl disable firewalld

sudo mysql -u root </vagrant/db_setup.sql
