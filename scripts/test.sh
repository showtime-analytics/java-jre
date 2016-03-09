#!/bin/bash

REPOSITORY=$1
VERSION=$2

cd $(dirname $0)/..

PROJECT_NAME=$(basename `pwd`)

: ${REPOSITORY:=${PROJECT_NAME}}
: ${VERSION:=`cat version`}

(set -x; docker run -i --rm ${REPOSITORY}:${VERSION} bash -c "bash --version && curl --version")