#!/bin/bash

DOCKERHUB_USER="gnasello"
CONTAINER_NAME="flowcyto-lylab"
VERSION='2025-01-31'

docker build --no-cache -t "${DOCKERHUB_USER}/${CONTAINER_NAME}:${VERSION}" .