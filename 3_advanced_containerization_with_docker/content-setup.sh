#!/bin/bash 

cd /vagrant
echo "* Invoke docker compose..."
docker compose up --build -d
echo "* Done..."