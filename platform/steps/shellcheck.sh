#! /usr/bin/env bash

set -euo pipefail

readarray -d "" FILES < <(find . -name "*.sh" -print0)

shellcheck --format=tty --color=always "${FILES[@]}"
