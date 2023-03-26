#! /usr/bin/env bash

set -euo pipefail

readarray -d "" FILES < <(find . -name "Dockerfile" -print0)

hadolint "${FILES[@]}"
