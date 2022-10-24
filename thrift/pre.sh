#!/bin/bash

if [[ $(timedatectl show | grep Timezone | cut -d= -f2) == "Asia/Shanghai" ]]; then
    if [[ -z ${UBUNTU_MIRROR_PATH+x} ]]; then
        export UBUNTU_MIRROR_PATH=http://mirrors.ustc.edu.cn
    fi
fi
export VSC_UBUNTU_IMAGE=${UBUNTU_IMAGE:-docker.io/yaekee/vsc-devcontainer-ubuntu:jammy-20221003}

THRIFT_VERSION=${THRIFT_VERSION:-$(curl -sL https://api.github.com/repos/apache/thrift/releases/latest | jq -r .tag_name)}
THRIFT_VERSION=${THRIFT_VERSION:-v0.17.0}
export THRIFT_VERSION=${THRIFT_VERSION:1}

add_image "docker.io/yaekee/vsc-devcontainer-thrift:${THRIFT_VERSION}"
