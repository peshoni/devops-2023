#!/bin/bash

echo "192.168.99.101 chef-wrkstn.do2.lab chef-wrkstn" >>/etc/hosts
echo "192.168.99.102 chef-server.do2.lab chef-server" >>/etc/hosts

echo "192.168.99.103 chef-client-1.do2.lab chef-client-1" >>/etc/hosts
echo "192.168.99.104 chef-client-2.do2.lab chef-client-2" >>/etc/hosts
echo "192.168.99.105 chef-client-3.do2.lab chef-client-3" >>/etc/hosts
