#!/bin/bash

LEADER_IP='192.168.99.101'

sshpass -p 'vagrant' ssh vagrant@docker1 docker swarm init --advertise-addr $LEADER_IP

WORKER_TOKEN=$(sshpass -p 'vagrant' ssh vagrant@docker1 docker swarm join-token -q worker) 
echo $WORKER_TOKEN >> pepe.txt
sshpass -p 'vagrant' ssh vagrant@docker2 docker swarm join --token $WORKER_TOKEN --advertise-addr 192.168.99.102 $LEADER_IP:2377
sshpass -p 'vagrant' ssh vagrant@docker3 docker swarm join --token $WORKER_TOKEN --advertise-addr 192.168.99.103 $LEADER_IP:2377
