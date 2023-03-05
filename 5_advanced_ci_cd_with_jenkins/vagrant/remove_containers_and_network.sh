#!/bin/bash

docker container rm --force vagrant-bg-app-front-1 vagrant-bg-app-db-1 || true
docker network rm vagrant_bg-cities-net || true
