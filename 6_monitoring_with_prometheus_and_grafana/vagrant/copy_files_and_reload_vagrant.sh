#!/bin/bash

# Use this script only in development mode to apply new configurations over the Prometheus machine

# Provide files and reload Prometheus
sudo cp -f /vagrant/prometheus.yml ./prometheus-2.42.0.linux-amd64/
sudo cp -f /vagrant/applications.json ./prometheus-2.42.0.linux-amd64/
sudo cp -f /vagrant/dockers.json ./prometheus-2.42.0.linux-amd64/
sudo cp -f /vagrant/rules.yml ./prometheus-2.42.0.linux-amd64/

curl -X POST http://192.168.99.101:9090/-/reload

# Provide files and reload alert manager
sudo cp -f /vagrant/alertmanager.yml ./alertmanager-0.25.0.linux-amd64/
curl -X POST http://192.168.99.101:9093/-/reload
