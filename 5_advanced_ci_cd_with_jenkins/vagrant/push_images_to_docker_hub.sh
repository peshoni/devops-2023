#!/bin/bash

source ./.env

echo $DOCKER_PASSWORD | docker login -u $DOCKER_USERNAME --password-stdin

docker tag m3-web pesho02/m3-web:latest
docker tag m3-db pesho02/m3-db:latest

docker push pesho02/m3-web:latest
docker push pesho02/m3-db:latest
