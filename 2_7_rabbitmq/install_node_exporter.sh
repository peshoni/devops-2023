#!/bin/bash

wget https://github.com/prometheus/node_exporter/releases/download/v1.5.0/node_exporter-1.5.0.linux-amd64.tar.gz
echo "* .gz was downloaded.."
tar xzvf node_exporter-1.5.0.linux-amd64.tar.gz
echo "* .gz was unzipped.."
rm node_exporter-1.5.0.linux-amd64.tar.gz
echo "* .gz was deleted.."

cd node_exporter-1.5.0.linux-amd64/

./node_exporter &>/tmp/node-exporter.log &

firewall-cmd --add-port 9100/tcp --permanent
firewall-cmd --reload
echo "* Node exporter metrics was exposed on :9100.."
