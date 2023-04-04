#!/bin/bash

wget https://github.com/prometheus/alertmanager/releases/download/v0.25.0/alertmanager-0.25.0.linux-amd64.tar.gz

tar xzvf alertmanager-0.25.0.linux-amd64.tar.gz
echo "* .gz was unzipped.."
rm alertmanager-0.25.0.linux-amd64.tar.gz
echo "* .gz was deleted.."

# Replace default .yml file with custom from synced Vagrant folder
sudo cp -f /vagrant/alertmanager.yml ./alertmanager-0.25.0.linux-amd64/

# Enter the folder
cd alertmanager-0.25.0.linux-amd64/
# And start it in background mode
./alertmanager &>/tmp/am.log &

echo "* Alert manager was started.."
