#!/bin/bash

# Change the parameter for system limits on mmap counts
sudo sysctl -w vm.max_map_count=262144

# correct the ownership
sudo chown -R vagrant:vagrant .docker

# Goto synced folder
cd /vagrant

# Create directory for `elasticsearch` volumes
mkdir -p data/es

# Build stack
docker compose up -d
