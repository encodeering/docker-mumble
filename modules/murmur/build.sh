#!/usr/bin/env bash

set -e

import com.encodeering.ci.config
import com.encodeering.ci.docker

docker-pull "$REPOSITORY/alpine-$ARCH:3.7" "alpine:3.7"

patch -p1 --no-backup-if-mismatch --directory="$PROJECT" < patch/Dockerfile.patch
patch -p1 --no-backup-if-mismatch --directory="$PROJECT" < patch/Entrypoint.patch

docker-build "$PROJECT/library/murmur"

docker-verify-config "--entrypoint murmurd"
docker-verify -version
