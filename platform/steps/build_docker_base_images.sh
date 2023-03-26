#! /usr/bin/env bash

set -euo pipefail

DOCKER_REGISTRY=$1

if [[ -z "$DOCKER_REGISTRY" ]]; then
  echo "DOCKER_REGISTRY argument is missing."
  exit 1
fi

export DOCKER_BUILDKIT=1

SCRIPT_DIRECTORY="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BASE_IMAGES_DIRECTORY="$(cd "$SCRIPT_DIRECTORY/../../docker_base_images" && pwd)"

echo "Building application as base-application..."
docker build -t "$DOCKER_REGISTRY/base-application" "$BASE_IMAGES_DIRECTORY/application"
echo
