#!/bin/bash

# correct the ownership
sudo chown -R vagrant:vagrant .docker

# Goto synced folder
cd /vagrant

# Build stack
docker compose up -d
