#!/bin/bash

if [[ $(timedatectl show | grep Timezone | cut -d= -f2) == "Asia/Shanghai" ]]; then
    if [[ -z ${UBUNTU_MIRROR_PATH+x} ]]; then
        export UBUNTU_MIRROR_PATH=http://mirrors.ustc.edu.cn
    fi
fi
export VSC_UBUNTU_IMAGE=${UBUNTU_IMAGE:-docker.io/yaekee/vsc-devcontainer-ubuntu:jammy-20221003}
export LIBWEBSOCKETS_VERSION=${LIBWEBSOCKETS_VERSION:-v4.0.7}
add_image "docker.io/yaekee/vsc-devcontainer-libwebsocket:${LIBWEBSOCKETS_VERSION}"
