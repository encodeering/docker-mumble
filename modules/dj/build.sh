#!/usr/bin/env bash

set -e

import com.encodeering.ci.config
import com.encodeering.ci.docker

docker-pull "$REPOSITORY/alpine-$ARCH:3.9" "alpine:3.8"

docker-patch patch "$PROJECT"

docker-build "$PROJECT"

docker-verify -version | dup | contains "v${VERSION}"
