#!/bin/bash

echo "* Start the Kefka-exporter container"
docker run -d --name kafka-exporter -p 9308:9308 danielqsj/kafka-exporter --kafka.server=192.168.99.100:9092
echo "* Done."
