#!/bin/bash

echo "* Start the Prometheus container"
docker container run -d --name prometheus -p 9090:9090 --mount type=bind,source=/vagrant/prometheus.yml,destination=/etc/prometheus/prometheus.yml/prometheus.yml,destination=/etc/prometheus/prometheus.yml prom/prometheus
echo "* Done."

echo "* Start the Grafana container"
# Create a volume for Grafana
docker volume create grafana
# start Grafana
docker run -d -p 3000:3000 --name grafana --rm -v grafana:/var/lib/grafana grafana/grafana-oss
echo "* Done."
