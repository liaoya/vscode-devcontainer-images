#!/bin/bash

if [[ $(timedatectl show | grep Timezone | cut -d= -f2) == "Asia/Shanghai" ]]; then
    if [[ -z ${UBUNTU_MIRROR_PATH+x} ]]; then
        export UBUNTU_MIRROR_PATH=http://mirrors.ustc.edu.cn
    fi
fi
export VSC_UBUNTU_IMAGE=${UBUNTU_IMAGE:-docker.io/yaekee/vsc-devcontainer-ubuntu:jammy-20221003}
SDKMAN_VERSION=${SDKMAN_VERSION:-curl -sL https://api.github.com/repos/sdkman/sdkman-cli/releases/latest | jq -r .tag_name}
SDKMAN_VERSION=${SDKMAN_VERSION:-5.16.0}
add_image "docker.io/yaekee/vsc-devcontainer-sdkman:${SDKMAN_VERSION}"
