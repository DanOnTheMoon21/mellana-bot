#!/bin/bash

DOCKER_NAME="${DOCKER_NAME:=mb}"
DOCKER_TAG="${DOCKER_TAG:=prod}"

cd $(git rev-parse --show-toplevel)

# build docker image
source ./.dev/docker.sh build

# bump version
current_version=$(cat .version)

IFS='.' read -a version_parts <<< "$current_version"

major=${version_parts[0]}
minor=${version_parts[1]}
patch=${version_parts[2]}

case "$1" in
  major)
    major=$((major + 1))
    minor=0
    patch=0
    ;;
  minor)
    minor=$((minor + 1))
    patch=0
    ;;
  patch)
    patch=$((patch + 1))
    ;;
  *)
    echo "Usage: $0 {major|minor|patch}"
    exit 1
esac

new_version="$major.$minor.$patch"

echo $new_version > .version

# git commit and tag
git add .
git commit -m "$new_version"
git tag "v$new_version"
git push --follow-tags

# docker tag
docker tag "$DOCKER_NAME:$DOCKER_TAG" "$DOCKER_NAME:$new_version"