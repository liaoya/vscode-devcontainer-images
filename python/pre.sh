#!/bin/bash

if [[ $(timedatectl show | grep Timezone | cut -d= -f2) == "Asia/Shanghai" ]]; then
    if [[ -z ${PIP_INDEX_URL+x} ]]; then
        export PIP_INDEX_URL=https://mirrors.ustc.edu.cn/pypi/web/simple
    fi
    if [[ -z ${PIP_TRUSTED_HOST+x} ]]; then
        export PIP_TRUSTED_HOST=mirrors.ustc.edu.cn
    fi
fi
export VSC_UBUNTU_IMAGE=${VSC_UBUNTU_IMAGE:-docker.io/yaekee/vsc-devcontainer-ubuntu:jammy}

#shellcheck disable=SC2086
add_image "docker.io/yaekee/vsc-devcontainer-python:$(echo ${VSC_UBUNTU_IMAGE} | cut -d: -f2)"
add_image docker.io/yaekee/vsc-devcontainer-python:latest
