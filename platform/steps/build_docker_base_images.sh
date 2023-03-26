#! /usr/bin/env bash

set -euo pipefail

DOCKER_REGISTRY=$1

if [[ -z "$DOCKER_REGISTRY" ]]; then
  echo "DOCKER_REGISTRY argument is missing."
  exit 1
fi

export DOCKER_BUILDKIT=1

SCRIPT_DIRECTORY="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOCKERFILE_DIRECTORY="$(cd "$SCRIPT_DIRECTORY/../../docker/base_application" && pwd)"

echo "Building application based on base-application..."
docker build -t "$DOCKER_REGISTRY/base-application" "$DOCKERFILE_DIRECTORY"
echo
