#! /usr/bin/env bash

set -euo pipefail

DOCKER_REGISTRY=$1
PROJECT_DIRECTORY=$2
UNIT_TEST_PROJECT=$3

SCRIPT_DIRECTORY="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

"$SCRIPT_DIRECTORY/dotnet/run_dotnet_command.sh" \
  "$DOCKER_REGISTRY" "$PROJECT_DIRECTORY" \
  "/run_dotnet_unit_test.sh" "$UNIT_TEST_PROJECT"
