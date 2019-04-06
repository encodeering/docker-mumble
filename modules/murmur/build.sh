#!/usr/bin/env bash

set -e

import com.encodeering.ci.config
import com.encodeering.ci.docker

docker-pull "$REPOSITORY/alpine-$ARCH:3.9" "alpine:3.9"

docker-patch patch "$PROJECT"

docker-build "$PROJECT/library/murmur"

docker-verify-config "--entrypoint murmurd"
docker-verify -version 2>&1 | dup | matches "${VERSION}\$"
