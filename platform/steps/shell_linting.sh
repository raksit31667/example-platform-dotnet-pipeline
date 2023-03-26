#! /usr/bin/env bash

set -euo pipefail

PROJECT_DIRECTORY=$1

export DOCKER_BUILDKIT=1

SCRIPT_DIRECTORY="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOCKERFILE_DIRECTORY="$(cd "$SCRIPT_DIRECTORY/../../docker/shell_linting" && pwd)"

docker build \
  -f "$DOCKERFILE_DIRECTORY/Dockerfile" \
  -t shell_linting \
  "$SCRIPT_DIRECTORY"

docker run \
  --rm \
  -v "$PROJECT_DIRECTORY:/project" \
  -w /project \
  shell_linting \
  shellcheck.sh

