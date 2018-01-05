#!/usr/bin/env bash
# configuration
#   env.ARCH
#   env.PROJECT
#   env.VERSION
#   env.REPOSITORY

set -e

import com.encodeering.docker.config
import com.encodeering.docker.docker

docker-pull "$REPOSITORY/alpine-$ARCH:3.7" "alpine:3.7"

patch -p1 --no-backup-if-mismatch --directory="$PROJECT" < patch/Dockerfile.patch
patch -p1 --no-backup-if-mismatch --directory="$PROJECT" < patch/Entrypoint.patch

docker build -t "$DOCKER_IMAGE" "$PROJECT/library/murmur"

docker run --rm --entrypoint murmurd "$DOCKER_IMAGE" -version