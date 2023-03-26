#! /usr/bin/env bash

set -euo pipefail

PROJECT_DIRECTORY=$1

export DOCKER_BUILDKIT=1

SCRIPT_DIRECTORY="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BASE_IMAGES_DIRECTORY="$(cd "$SCRIPT_DIRECTORY/../../docker" && pwd)"

docker build \
  -f "$BASE_IMAGES_DIRECTORY/shell_linting/Dockerfile" \
  -t shell_linting \
  "$SCRIPT_DIRECTORY"

docker run \
  --rm \
  -v "$PROJECT_DIRECTORY:/project" \
  -w /project \
  shell_linting \
  shellcheck.sh

