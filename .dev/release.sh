#!/bin/bash

DOCKER_NAME="${DOCKER_NAME:=mb}"
DOCKER_TAG="${DOCKER_TAG:=prod}"
DOCKER_REPO="${DOCKER_REPO:=danonthemoon21/mellana-bot}"

cd $(git rev-parse --show-toplevel)

# build prod docker image
source ./.dev/docker.sh build
source ./.dev/docker.sh push

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
git push && git push --tags

# docker tag & push
docker tag "$DOCKER_NAME:$DOCKER_TAG" "$DOCKER_NAME:$new_version"
docker push "$DOCKER_REPO:$new_version"