#! /usr/bin/env bash

set -euo pipefail

DOCKER_REGISTRY=$1

export DOCKER_BUILDKIT=1

echo "Pushing Docker base image for running .NET commands..."
docker push "$DOCKER_REGISTRY/base-dotnet-command"
echo

echo "Building Docker base image for running .NET application..."
docker push "$DOCKER_REGISTRY/base-application"
echo

echo "Building Docker base image for running .NET application..."
docker push "$DOCKER_REGISTRY/http-stubbing"
echo
