#!/bin/bash

docker images --quiet --filter=dangling=true | xargs --no-run-if-empty docker rmi
docker-compose stop
