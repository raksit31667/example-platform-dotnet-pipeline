#! /usr/bin/env bash

set -euo pipefail

DOCKER_REGISTRY=$1
DOCKER_REPOSITORY=$2
DLL_FILE_NAME=$3
BUILD_DIRECTORY=$4
BUILD_NUMBER=${5:-latest}

if [[ -z "$DOCKER_REGISTRY" ]]; then
  echo "DOCKER_REGISTRY argument is missing."
  exit 1
fi

if [[ -z "$DOCKER_REPOSITORY" ]]; then
  echo "DOCKER_REPOSITORY argument is missing."
  exit 1
fi

if [[ -z "$DLL_FILE_NAME" ]]; then
  echo "DLL_FILE_NAME argument is missing."
  exit 1
fi

if [[ -z "$BUILD_DIRECTORY" ]]; then
  echo "BUILD_DIRECTORY argument is missing."
  exit 1
fi

export DOCKER_BUILDKIT=1

SCRIPT_DIRECTORY="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

docker build \
  -f "$SCRIPT_DIRECTORY"/Dockerfile \
  --build-arg BASE_IMAGE="$DOCKER_REGISTRY/base-application" \
  --build-arg DLL_ENTRYPOINT="**$DLL_FILE_NAME" \
  -t "$DOCKER_REGISTRY/$DOCKER_REPOSITORY:$BUILD_NUMBER" \
  "$BUILD_DIRECTORY"
