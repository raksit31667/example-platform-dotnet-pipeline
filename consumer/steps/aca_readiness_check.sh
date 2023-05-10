#! /usr/bin/env bash

set -euo pipefail

ACA_NAME=$1
ACA_RESOURCE_GROUP=$2
BUILD_NUMBER=$3

az config set extension.use_dynamic_install=yes_without_prompt # Install extension automatically

PROVISIONING_STATE="Provisioning"
while [[ "$PROVISIONING_STATE" == "Provisioning" ]]; do
  echo "Waiting for provisioning..."
  sleep 10
  echo "Checking provisioning state..."
  PROVISIONING_STATE=$(az containerapp revision list -n "$ACA_NAME" -g "$ACA_RESOURCE_GROUP" --query "[?contains(properties.template.containers[0].image, '$BUILD_NUMBER')].properties.provisioningState" -o tsv)
done
if [[ "$PROVISIONING_STATE" == "Provisioned" ]]; then
  echo "ACA deployment successful"
  exit 0
else
  echo "ACA deployment failed"
  exit 1
fi
