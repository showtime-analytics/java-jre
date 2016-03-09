#!/bin/bash

source $(dirname $0)/variables.sh

cd $(dirname $0)/..

if [ ! -f build_version ]; then
    echo "File \"build_version\" not found!"
    exit 1
fi

(set -x; ./scripts/test.sh $IMAGE_NAME `cat build_version`)