#!/usr/bin/env bash

set -eo pipefail

cd "$(dirname "$(readlink -f "$BASH_SOURCE")")"

versions=( "$@" )
if [ ${#versions[@]} -eq 0 ]; then
	versions=( */ )
fi

versions=( "${versions[@]%/}" )

for version in "${versions[@]}"; do
  [ -f "$version/Dockerfile" ] || continue
  docker build --rm -t tbartels/php:"$version" "$version/."
  OUTPUT=$(docker run --rm tbartels/php:"$version" php --version 2>&1)
  echo $OUTPUT
  if ! echo "$OUTPUT" | grep -q "$version"; then
    echo "Test of PHP$version failed!"
    exit 1
  fi
done
