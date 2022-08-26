#!/bin/bash

if [[ -z ${ALPINE_MIRROR_PATH+x} ]]; then
    ALPINE_MIRROR_PATH=http://mirrors.ustc.edu.cn
fi
export BASE_IMAGE=${BASE_IMAGE:-docker.io/library/alpine:3.16.2}
ALPINE_VERSION=$(echo "${BASE_IMAGE}" | cut -d":" -f2)
add_image "docker.io/yaekee/devcontainer-base:alpine-${ALPINE_VERSION}"