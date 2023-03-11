#!/bin/bash

wget https://github.com/prometheus/prometheus/releases/download/v2.42.0/prometheus-2.42.0.linux-amd64.tar.gz

tar xzvf prometheus-2.42.0.linux-amd64.tar.gz
echo "* .gz was unzipped.."
rm prometheus-2.42.0.linux-amd64.tar.gz
echo "* .gz was deleted.."

# replace default .yml file with custom from synced Vagrant folder
sudo cp -f /vagrant/prometheus.yml ./prometheus-2.42.0.linux-amd64/
sudo cp -f /vagrant/applications.json ./prometheus-2.42.0.linux-amd64/
sudo cp -f /vagrant/dockers.json ./prometheus-2.42.0.linux-amd64/
sudo cp -f /vagrant/rules.yml ./prometheus-2.42.0.linux-amd64/

echo "* configurations were replaced.."

cd prometheus-2.42.0.linux-amd64

# Run prometheus
echo "* Run prometheus.."
./prometheus --config.file prometheus.yml --web.enable-lifecycle 2>>/tmp/prometheus.log &
