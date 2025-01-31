#!/bin/bash

DOCKERHUB_USER="gnasello"
CONTAINER_NAME="flowcyto-lylab"
VERSION='2025-01-31'

docker push "${DOCKERHUB_USER}/${CONTAINER_NAME}:${VERSION}"

docker tag "${DOCKERHUB_USER}/${CONTAINER_NAME}:${VERSION}" "${DOCKERHUB_USER}/${CONTAINER_NAME}:latest" 

docker push "${DOCKERHUB_USER}/${CONTAINER_NAME}:latest"