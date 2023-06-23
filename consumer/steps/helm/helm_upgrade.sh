#! /usr/bin/env bash

set -euo pipefail

KUBERNETES_NAMESPACE=$1
HELM_RELEASE_NAME=$2
BUILD_NUMBER=$3
INGRESS_PATH=$4

helm upgrade --install --wait --debug --atomic \
  --namespace "$KUBERNETES_NAMESPACE" \
  --values "/values.yaml" \
  "$HELM_RELEASE_NAME" \
  "/helm-chart-directory" \
  --set-string image.tag="$BUILD_NUMBER" \
  --set-string ingress.path="$INGRESS_PATH"
