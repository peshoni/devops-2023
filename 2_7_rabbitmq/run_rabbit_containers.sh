#!/bin/bash

# docker run -d --rm --name rabbitmq-1 -p 5672:5672 -p 15672:15672 -p 15692:15692 rabbitmq:3.11-management

# • 5672 is used by the applications (pushers and consumers) that interact with the service
# • 15672 is used to reach the web-based management interface of the service
# • 15692 is used to expose Prometheus metrics (we will come back to this later)

# Prepare settings for the cluster
mkdir -p rabbitmq/node-{1..3}

cat <<EOF | tee rabbitmq/node-{1..3}/rabbitmq
cluster_formation.peer_discovery_backend = rabbit_peer_discovery_classic_config 
cluster_formation.classic_config.nodes.1 = rabbit@rabbitmq-1 
cluster_formation.classic_config.nodes.2 = rabbit@rabbitmq-2 
cluster_formation.classic_config.nodes.3 = rabbit@rabbitmq-3
EOF
# create network
docker network create rabbitmq-net
# -p 5672:5672 -p 15672:15672 -p 15692:15692 -p 9101:9100 ...
# Run containers
docker run -d --rm --name rabbitmq-1 --hostname rabbitmq-1 --net rabbitmq-net -p 8081:15672 -p 9081:15692 -v ${PWD}/rabbitmq/node-1/:/config/ -e RABBITMQ_CONFIG_FILE=/config/rabbitmq -e RABBITMQ_ERLANG_COOKIE=ABCDEFFGHIJKLMOP rabbitmq:3.11-management
docker run -d --rm --name rabbitmq-2 --hostname rabbitmq-2 --net rabbitmq-net -p 8082:15672 -p 9082:15692 -v ${PWD}/rabbitmq/node-2/:/config/ -e RABBITMQ_CONFIG_FILE=/config/rabbitmq -e RABBITMQ_ERLANG_COOKIE=ABCDEFFGHIJKLMOP rabbitmq:3.11-management
docker run -d --rm --name rabbitmq-3 --hostname rabbitmq-3 --net rabbitmq-net -p 8083:15672 -p 9083:15692 -v ${PWD}/rabbitmq/node-3/:/config/ -e RABBITMQ_CONFIG_FILE=/config/rabbitmq -e RABBITMQ_ERLANG_COOKIE=ABCDEFFGHIJKLMOP rabbitmq:3.11-management

# docker run -d --rm --name rabbitmq-3 --hostname rabbitmq-3 --net rabbitmq-net -p 8083:15672 -p 9083:15692 -v ${PWD}/rabbitmq/node-3/:/config/ -v ${PWD}/vagrant/consumer/*:/usr/src/scr/ -e RABBITMQ_CONFIG_FILE=/config/rabbitmq -e RABBITMQ_ERLANG_COOKIE=ABCDEFFGHIJKLMOP rabbitmq:3.11-management

# sudo docker cp recv_log_topic.py rabbitmq-3:/usr/src/scr/docker container ls

# sudo systemctl daemon-reload
# sudo systemctl restart docker

# Hand operation : Enable federation
# docker container exec -it rabbitmq-1 rabbitmq-plugins enable rabbitmq_federation
# docker container exec -it rabbitmq-2 rabbitmq-plugins enable rabbitmq_federation
# docker container exec -it rabbitmq-3 rabbitmq-plugins enable rabbitmq_federation

# sudo docker cp emit_log_topic.py rabbitmq-1:usr/
# sudo docker cp recv_log_topic.py rabbitmq-2:usr/
# sudo docker cp recv_log_topic.py rabbitmq-3:usr/

# docker exec -it rabbitmq-2 bash

# Install Python in all of containers
# apt-get update
# apt-get install python3
# apt-get install -y python3-pip
# python3 -m pip install pika --upgrade

# rabbitmq-1 :  python3 emit_log_topic.py
# rabbitmq-2 :  python3 recv_log_topic.py "cpu.warn" "cpu.crit"
# rabbitmq-3 :  python3 recv_log_topic.py "ram.*"

# Create the cluster

#  firewall
