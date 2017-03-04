#!/bin/bash

export GAZELLE_PORT=8080
export OCELOT_PORT=34000
export PHPMYADMIN_PORT=8081
export PATH_TO_GAZELLE_REPO=../Gazelle
export PATH_TO_CONFIG_FILES=./devconfig

rm -rf docker-compose.yml
envsubst < "template.yml" > "docker-compose.yml" && echo "Environment created!"

docker images --quiet --filter=dangling=true | xargs docker rmi
docker-compose up --build
