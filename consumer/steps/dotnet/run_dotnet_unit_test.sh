#! /usr/bin/env bash

set -euo pipefail

UNIT_TEST_PROJECT=$1

dotnet restore
if dotnet list "$UNIT_TEST_PROJECT" package | grep coverlet.collector; then
  dotnet test "$UNIT_TEST_PROJECT" --collect:"XPlat Code Coverage" --results-directory ./unit-test-results/ --logger "trx;LogFileName=$UNIT_TEST_PROJECT.trx"
else
  dotnet test "$UNIT_TEST_PROJECT" --logger "trx;LogFileName=$UNIT_TEST_PROJECT.trx"
  echo "##[task.logissue type=warning]Code coverage is disabled because coverlet.collector is not installed in $UNIT_TEST_PROJECT."
  echo "##[task.logissue type=warning]To enable it, run \"dotnet add $UNIT_TEST_PROJECT package coverlet.collector -v <version>\"."
fi
