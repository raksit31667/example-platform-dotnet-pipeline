#! /usr/bin/env bash

set -euo pipefail

PACKAGE_NAME=$1
BUILD_NUMBER=$2

dotnet build -c Release "$PACKAGE_NAME"
dotnet publish -p:Version="$BUILD_NUMBER" -c Release -o app "./$PACKAGE_NAME"
