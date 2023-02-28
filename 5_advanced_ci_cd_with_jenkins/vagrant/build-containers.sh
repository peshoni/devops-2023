#!/bin/bash

# Invoke with: bash build-containers.sh

cd /vagrant
echo "* Invoke docker compose..."
# docker compose up --build -d
docker compose -f docker-compose-builder.yml up --build -d
echo "* Done..."

# docker compose -f docker-compose-builder.yml up --build -d
