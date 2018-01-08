#!/usr/bin/env bash

set -e

import com.encodeering.docker.config
import com.encodeering.docker.docker

docker-pull "$REPOSITORY/alpine-$ARCH:3.7" "alpine:3.7"

patch -p1 --no-backup-if-mismatch --directory="$PROJECT" < patch/Dockerfile.patch
patch -p1 --no-backup-if-mismatch --directory="$PROJECT" < patch/Makefile.patch

docker build -t "$DOCKER_IMAGE" "$PROJECT"

docker run --rm "$DOCKER_IMAGE" -version
