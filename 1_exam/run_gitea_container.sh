#!/bin/bash

cd /vagrant
echo "* Invoke docker compose for Gitea..."
docker compose -f docker-compose-gitea.yml up -d
echo "* Done..."
