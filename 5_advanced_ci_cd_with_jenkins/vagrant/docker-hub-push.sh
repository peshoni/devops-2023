#!/bin/bash

source ./.env

# docker image build -t image-web -f Dockerfile.web .

# echo $DOCKER_PASSWORD
# echo $DOCKER_USERNAME

# AFTER=$(echo $DOCKER_USERNAME | sed 's/\\r//g')

echo $DOCKER_PASSWORD | docker login -u $DOCKER_USERNAME --password-stdin

# docker build -t m3-web .
# docker images
docker tag m3-web:latest pesho02/m3-web:latest
docker tag m3-db:latest pesho02/m3-db:latest

docker push pesho02/m3-web:latest
docker push pesho02/m3-db:latest
