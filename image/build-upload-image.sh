#!/bin/bash

DOCKER_REPO=kyuriy

docker build -t ${DOCKER_REPO}/hello-name:latest .
docker push ${DOCKER_REPO}/hello-name:latest
