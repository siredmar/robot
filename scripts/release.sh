#!/usr/bin/env bash

set -e

### globals ####################################################################

this_path="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
release_name=$(cat "$this_path/../release_name")

### main #######################################################################

if [ -z "$1" ]; then
  echo "Usage: $0 REPOSITORY_URL"
  echo ""
  echo "  e.g.: $0 https://your.registry.com:5000/rfdocker"
  exit 64
fi

echo "### Creating a git tag '$release_name' for the release"
git tag --force --annotate --message "Release $release_name" "$release_name"

repository_url="$1"

echo "### Tagging image 'rfdocker:$release_name' to '$repository_url:$release_name'"
docker tag "rfdocker:$release_name" "$repository_url:$release_name"

echo "### Pushing image 'rfdocker:$release_name' to registry..."
docker push "$repository_url:$release_name"
