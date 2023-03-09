#!/bin/bash

wget https://github.com/prometheus/node_exporter/releases/download/v1.5.0/node_exporter-1.5.0.linux-amd64.tar.gz
echo "* .gz was downloaded.."
tar xzvf node_exporter-1.5.0.linux-amd64.tar.gz
echo "* .gz was unzipped.."
rm node_exporter-1.5.0.linux-amd64.tar.gz
echo "* .gz was deleted.."

cd node_exporter-1.5.0.linux-amd64/

# ./node_exporter
./node_exporter &>/tmp/node-exporter.log &

docker container run -d --name worker1 -p 8081:8080 shekeriev/goprom

# /vagrant/goprom/runner.sh http://192.168.99.103:8081 &> /tmp/runner8081.log &
