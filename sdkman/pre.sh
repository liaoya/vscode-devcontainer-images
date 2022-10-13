#!/bin/bash

if [[ $(timedatectl show | grep Timezone | cut -d= -f2) == "Asia/Shanghai" ]]; then
    if [[ -z ${UBUNTU_MIRROR_PATH+x} ]]; then
        export UBUNTU_MIRROR_PATH=http://mirrors.ustc.edu.cn
    fi
fi
export UBUNTU_IMAGE=${UBUNTU_IMAGE:-docker.io/library/ubuntu:jammy-20221003}
UBUNTU_VERSION=$(echo "${UBUNTU_IMAGE}" | cut -d":" -f2)
add_image "docker.io/yaekee/vsc-devcontainer-sdkman:${UBUNTU_VERSION}"
