#! /usr/bin/env bash

set -euo pipefail

INTEGRATION_TEST_PROJECT=$1

dotnet restore

dotnet test "$INTEGRATION_TEST_PROJECT" --logger "trx;LogFileName=$INTEGRATION_TEST_PROJECT.trx"
