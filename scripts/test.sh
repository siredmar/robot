#!/usr/bin/env bash

set -e

### globals ####################################################################

this_path="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
release_name="$(cat "$this_path/../release_name")"
temp_results_path="/tmp/rfdocker-tests"

### main #######################################################################

mkdir -p "$temp_results_path"

docker run --rm -ti -e UID=$UID -e GID=$GID \
  -v "$this_path/..":/home/robot \
  "rfdocker:$release_name" tests/
