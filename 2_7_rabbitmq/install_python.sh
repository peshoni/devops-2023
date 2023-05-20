#!/bin/bash

sudo dnf install -y python3 python3-pip
sudo update-alternatives --config python
sudo python -m pip install pika --upgrade
