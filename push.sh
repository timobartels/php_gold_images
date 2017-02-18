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
    docker login --username=$docker_username --password=$docker_password
    docker push tbartels/php:"$version"
    docker rmi tbartels/php:"$version"
done
