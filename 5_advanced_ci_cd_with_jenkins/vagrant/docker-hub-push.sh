#!/bin/bash

# docker image build -t image-web -f Dockerfile.web .

echo "$DOCKER_PASSWORD" | docker login -u "$DOCKER_USERNAME" --password-stdin
# docker build -t m3-web .
# docker images
# docker tag m3-web:latest "$DOCKER_USERNAME"/m3-web:latest
docker push "$DOCKER_USERNAME"/m3-web:latest
docker push "$DOCKER_USERNAME"/m3-db:latest
