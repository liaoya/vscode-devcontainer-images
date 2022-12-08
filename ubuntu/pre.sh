#!/bin/bash

if [[ $(timedatectl show | grep Timezone | cut -d= -f2) == "Asia/Shanghai" ]]; then
    if [[ -z ${UBUNTU_MIRROR_PATH+x} ]]; then
        export UBUNTU_MIRROR_PATH=http://mirrors.ustc.edu.cn
    fi
fi
export UBUNTU_IMAGE=${UBUNTU_IMAGE:-docker.io/library/ubuntu:jammy-20221101}
UBUNTU_VERSION=$(echo "${UBUNTU_IMAGE}" | cut -d":" -f2)
add_image "docker.io/yaekee/vsc-devcontainer-ubuntu:${UBUNTU_VERSION}"
#shellcheck disable=SC2086
add_image "docker.io/yaekee/vsc-devcontainer-ubuntu:$(echo ${UBUNTU_VERSION} | cut -d- -f1)"
if [[ "${UBUNTU_VERSION}" =~ "jammy" ]]; then
    add_image docker.io/yaekee/vsc-devcontainer-ubuntu:22.04
elif [[ "${UBUNTU_VERSION}" =~ "focal" ]]; then
    add_image docker.io/yaekee/vsc-devcontainer-ubuntu:20.04
fi
