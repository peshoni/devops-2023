#!/bin/bash

sudo firewall-cmd --add-port=80/tcp --permanent
sudo firewall-cmd --reload
