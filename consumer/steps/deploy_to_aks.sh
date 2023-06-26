#! /usr/bin/env bash

AZURE_DEVOPS_KUBECONFIG=${KUBECONFIG:-$HOME/.kube/config}

set -euo pipefail

DOCKER_REGISTRY=$1
KUBERNETES_NAMESPACE=$2
HELM_RELEASE_NAME=$3
BUILD_NUMBER=$4
INGRESS_PATH=$5
HELM_VALUES_FILE_DIRECTORY=$6
HELM_CHART_DIRECTORY=$7

export DOCKER_BUILDKIT=1

docker run \
  --rm \
  -e "KUBECONFIG=/.azure-devops-kubeconfig" \
  -v "$AZURE_DEVOPS_KUBECONFIG":/.azure-devops-kubeconfig \
  -v "$HELM_VALUES_FILE_DIRECTORY":/values.yaml \
  -v "$HELM_CHART_DIRECTORY":/helm-chart-directory \
  "$DOCKER_REGISTRY/helm" \
  "/helm_upgrade.sh $KUBERNETES_NAMESPACE $HELM_RELEASE_NAME $BUILD_NUMBER $INGRESS_PATH"
