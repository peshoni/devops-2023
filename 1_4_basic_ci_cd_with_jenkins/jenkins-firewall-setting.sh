#!/bin/bash
  

echo "* Prepare firewall for Jenkinsen: add ports 80, 8080 ..."
firewall-cmd --permanent --add-port=8080/tcp 
firewall-cmd --permanent --add-port=80/tcp
firewall-cmd --reload