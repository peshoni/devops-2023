#!/bin/bash

wget https://github.com/prometheus/prometheus/releases/download/v2.42.0/prometheus-2.42.0.linux-amd64.tar.gz

tar xzvf prometheus-2.42.0.linux-amd64.tar.gz
echo "* .gz was unzipped.."
rm prometheus-2.42.0.linux-amd64.tar.gz
echo "* .gz was deleted.."
# replace default .yml file with custom from synced Vagrant folder
sudo cp -f /vagrant/prometheus.yml ./prometheus-2.42.0.linux-amd64/
echo "* prometheus.yml is replaced.."

cd prometheus-2.42.0.linux-amd64

# Run prometheus
echo "* Run prometheus.."
./prometheus --config.file prometheus.yml --web.enable-lifecycle 2>>/tmp/prometheus.log &
