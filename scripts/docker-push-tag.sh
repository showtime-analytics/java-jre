#!/bin/bash

source $(dirname $0)/variables.sh

cd $(dirname $0)/..

DOCKER_REGISTRY=$1
BUILD_VERSION=$2
RELEASE_VERSION=$3

REPOSITORY=${DOCKER_REGISTRY}/${IMAGE_NAME}

set -x

if [ $DOCKER_REGISTRY = "showtimeanalytics" ]; then
    docker login --email="${DOCKER_HUB_EMAIL}" --username="${DOCKER_HUB_USERNAME}" --password="${DOCKER_HUB_PASSWORD}"
fi

# Push build version
docker tag -f ${IMAGE_NAME}:${BUILD_VERSION} ${REPOSITORY}:${BUILD_VERSION}
docker push ${REPOSITORY}:${BUILD_VERSION}

# Push release version
docker tag -f ${IMAGE_NAME}:${BUILD_VERSION} ${REPOSITORY}:${RELEASE_VERSION}
docker push ${REPOSITORY}:${RELEASE_VERSION}

# Clean images
docker rmi ${REPOSITORY}:${RELEASE_VERSION}
docker rmi ${REPOSITORY}:${BUILD_VERSION}
docker rmi ${IMAGE_NAME}:${BUILD_VERSION}
