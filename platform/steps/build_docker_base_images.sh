#! /usr/bin/env bash

set -euo pipefail

DOCKER_REGISTRY=$1

SCRIPT_DIRECTORY="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

export DOCKER_BUILDKIT=1

BASE_DOTNET_COMMAND_DOCKERFILE_DIRECTORY="$(cd "$SCRIPT_DIRECTORY/../../docker/base_dotnet_command" && pwd)"
DOTNET_COMMAND_DIRECTORY="$(cd "$SCRIPT_DIRECTORY/../../consumer/steps/dotnet" && pwd)"

echo "Building Docker base image for running .NET commands..."
docker build \
  -f "$BASE_DOTNET_COMMAND_DOCKERFILE_DIRECTORY/Dockerfile" \
  -t "$DOCKER_REGISTRY/base-dotnet-command" \
  "$DOTNET_COMMAND_DIRECTORY"
echo

BASE_APPLICATION_DOCKERFILE_DIRECTORY="$(cd "$SCRIPT_DIRECTORY/../../docker/base_application" && pwd)"

echo "Building application based on base-application..."
docker build -t "$DOCKER_REGISTRY/base-application" "$BASE_APPLICATION_DOCKERFILE_DIRECTORY"
echo
