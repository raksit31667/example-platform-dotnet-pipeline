#! /usr/bin/env bash

set -euo pipefail

DOCKER_REGISTRY=$1

export DOCKER_BUILDKIT=1

echo "Pushing Docker base image for running .NET commands..."
docker push "$DOCKER_REGISTRY/base-dotnet-command"
echo

echo "Pushing Docker base image for running .NET application..."
docker push "$DOCKER_REGISTRY/base-application"
echo

echo "Pushing Docker base image for running HTTP stub server..."
docker push "$DOCKER_REGISTRY/http-stub-server"
echo

echo "Pushing Docker base image for running HTTP stub reverse proxy..."
docker push "$DOCKER_REGISTRY/http-stub-server-proxy"
echo

echo "Pushing Docker base image for running Helm commands..."
docker push "$DOCKER_REGISTRY/helm"
echo
