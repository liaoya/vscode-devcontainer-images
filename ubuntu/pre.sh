#!/bin/bash

if [[ -z ${UBUNTU_MIRROR_PATH+x} ]]; then
    UBUNTU_MIRROR_PATH=http://mirrors.ustc.edu.cn
fi
export BASE_IMAGE=${BASE_IMAGE:-docker.io/library/ubuntu:22.04}
UBUNTU_VERSION=$(echo "${BASE_IMAGE}" | cut -d":" -f2)
add_image "docker.io/yaekee/devcontainer-base:ubuntu-${UBUNTU_VERSION}"