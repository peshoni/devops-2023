#!/bin/bash

LEADER_IP='192.168.99.103'
echo LEADER_IP >> pepe.txt
docker swarm init --advertise-addr $LEADER_IP
echo 'swarm init' >> pepe.txt
WORKER_TOKEN= docker swarm join-token -q worker 
echo $WORKER_TOKEN >> pepe.txt
sshpass -p 'vagrant' ssh vagrant@docker2 docker swarm join --token $WORKER_TOKEN --advertise-addr 192.168.99.102 $LEADER_IP:2377
sshpass -p 'vagrant' ssh vagrant@docker1 docker swarm join --token $WORKER_TOKEN --advertise-addr 192.168.99.101 $LEADER_IP:2377
echo 'Done' >> pepe.txt
docker stack deploy -c docker-compose.yml bgapp