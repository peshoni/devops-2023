#!/bin/bash

# Create a volume for Grafana
docker volume create grafana
# start Grafana
docker run -d -p 3000:3000 --name grafana --rm -v grafana:/var/lib/grafana grafana/grafana-oss
