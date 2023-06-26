#! /usr/bin/env bash

set -euo pipefail

KUBERNETES_NAMESPACE=$1
HELM_RELEASE_NAME=$2
BUILD_NUMBER=$3
INGRESS_PATH=$4

# Run Helm with another process so that even when current process is abort (getting signal SIGTERM),
# Helm can still either finish deploying or rolling back.
exec helm upgrade --install --wait --debug --atomic \
  --namespace "$KUBERNETES_NAMESPACE" \
  --values "/values.yaml" \
  "$HELM_RELEASE_NAME" \
  "/helm-chart-directory" \
  --set-string image.tag="$BUILD_NUMBER" \
  --set-string ingress.path="$INGRESS_PATH"
