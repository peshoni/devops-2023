#!/bin/bash
#!/bin/bash

# Using synced folder:  /vagrant-docker

cd /vagrant
echo "* Invoke docker compose..."
docker compose -f docker-compose-gitea.yml up -d
echo "* Done..."
