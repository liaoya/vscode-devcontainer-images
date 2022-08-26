#!/bin/bash

if [[ -z ${DEBIAN_MIRROR_PATH+x} ]]; then
    DEBIAN_MIRROR_PATH=http://mirrors.ustc.edu.cn
fi
export BASE_IMAGE=${BASE_IMAGE:-docker.io/library/debian:bullseye}
DEBIAN_VERSION=$(echo "${BASE_IMAGE}" | cut -d":" -f2)
add_image "docker.io/yaekee/devcontainer-base:debian-${DEBIAN_VERSION}"