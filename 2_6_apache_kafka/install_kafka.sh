#!/bin/bash

# Preparation
sudo dnf install -y java-17-openjdk

sudo systemctl disable --now firewalld

# Actual installation
wget https://archive.apache.org/dist/kafka/3.3.1/kafka_2.13-3.3.1.tgz
tar xzvf kafka_2.13-3.3.1.tgz
mv kafka_2.13-3.3.1 kafka

cd kafka

# run daemons
sudo bin/zookeeper-server-start.sh -daemon config/zookeeper.properties
sudo bin/kafka-server-start.sh -daemon config/server.properties
# create topic
bin/kafka-topics.sh --create --bootstrap-server localhost:9092 --replication-factor 1 --partitions 3 --topic topic1

# sudo dnf install -y telnet
# srvr

#  bin/kafka-console-producer.sh --broker-list localhost:9092 --topic topic1          disable seesion for input messages:   CTRL+D CTRL+C
# cat /tmp/kafka-logs/topic1-0/00000000000000000000.log
# bin/kafka-run-class.sh kafka.tools.DumpLogSegments --deep-iteration --print-data-log --files /tmp/kafka-logs/topic1-0/00000000000000000000.log
