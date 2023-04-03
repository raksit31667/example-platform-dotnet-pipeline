#! /usr/bin/env bash

set -euo pipefail

DOCKER_REGISTRY=$1
DOCKER_REPOSITORY=$2
DLL_FILE_NAME=$3
BUILD_DIRECTORY=$4
BUILD_NUMBER=${5:-latest}

export DOCKER_BUILDKIT=1

SCRIPT_DIRECTORY="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOCKERFILE_DIRECTORY="$(cd "$SCRIPT_DIRECTORY/../../docker/application" && pwd)"

docker build \
  -f "$DOCKERFILE_DIRECTORY"/Dockerfile \
  --build-arg BASE_IMAGE="$DOCKER_REGISTRY/base-application" \
  --build-arg DLL_ENTRYPOINT="**$DLL_FILE_NAME" \
  -t "$DOCKER_REGISTRY/$DOCKER_REPOSITORY:$BUILD_NUMBER" \
  "$BUILD_DIRECTORY"
