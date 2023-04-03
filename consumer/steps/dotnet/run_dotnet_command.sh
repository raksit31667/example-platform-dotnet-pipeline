#! /usr/bin/env bash

set -euo pipefail

DOCKER_REGISTRY=$1
PROJECT_DIRECTORY=$2

export DOCKER_BUILDKIT=1

docker run \
  --rm \
  -v "$PROJECT_DIRECTORY:/project" \
  -w "/project" \
  "$DOCKER_REGISTRY/base-dotnet-command" \
  "${@:3}"
