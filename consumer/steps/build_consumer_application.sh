#! /usr/bin/env bash

set -euo pipefail

DOCKER_REGISTRY=$1
PROJECT_DIRECTORY=$2
PACKAGE_NAME=$3
BUILD_NUMBER=${4:-"0.0.0"}

SCRIPT_DIRECTORY="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

"$SCRIPT_DIRECTORY/dotnet/run_dotnet_command.sh" \
  "$DOCKER_REGISTRY" "$PROJECT_DIRECTORY" \
  "/run_dotnet_build.sh" "$PACKAGE_NAME" "$BUILD_NUMBER"
