#!/bin/bash
set -e

if [ "${TRAVIS_PULL_REQUEST}" != "false" ]; then
  exit 0
fi

echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin

for variant in dev latest; do
  echo "Creating manifest file homeautomationstack/fhem-ssh:$variant ..."
  docker manifest create homeautomationstack/fhem-ssh:$variant \
    homeautomationstack/fhem-ssh-amd64_linux:$variant \
    homeautomationstack/fhem-ssh-i386_linux:$variant \
    homeautomationstack/fhem-ssh-arm32v5_linux:$variant \
    homeautomationstack/fhem-ssh-arm32v7_linux:$variant \
    homeautomationstack/fhem-ssh-arm64v8_linux:$variant
  docker manifest annotate homeautomationstack/fhem-ssh:$variant homeautomationstack/fhem-ssh-arm32v5_linux:$variant --os linux --arch arm --variant v5
  docker manifest annotate homeautomationstack/fhem-ssh:$variant homeautomationstack/fhem-ssh-arm32v7_linux:$variant --os linux --arch arm --variant v7
  docker manifest annotate homeautomationstack/fhem-ssh:$variant homeautomationstack/fhem-ssh-arm64v8_linux:$variant --os linux --arch arm64 --variant v8
  docker manifest inspect homeautomationstack/fhem-ssh:$variant

  echo "Pushing manifest homeautomationstack/fhem-ssh:$variant to Docker Hub ..."
  docker manifest push homeautomationstack/fhem-ssh:$variant

  echo "Requesting current manifest from Docker Hub ..."
  docker run --rm mplatform/mquery homeautomationstack/fhem-ssh:$variant
done
