#!/usr/bin/env bash

set -e

import com.encodeering.ci.config
import com.encodeering.ci.docker

docker-pull "$REPOSITORY/debian-$ARCH:bookworm" "ubuntu:22.04"

docker-build --build-arg "MUMBLE_VERSION=v$VERSION" "$PROJECT"

docker-verify-config "--entrypoint mumble-server"
docker-verify --version 2>&1 | dup | matches "$VERSION\$"
