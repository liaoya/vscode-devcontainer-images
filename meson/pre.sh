#!/bin/bash

if [[ $(timedatectl show | grep Timezone | cut -d= -f2) == "Asia/Shanghai" ]]; then
    if [[ -z ${UBUNTU_MIRROR_PATH+x} ]]; then
        export UBUNTU_MIRROR_PATH=http://mirrors.ustc.edu.cn
    fi
    if [[ -z ${PIP_INDEX_URL+x} ]]; then
        export PIP_INDEX_URL=https://mirrors.ustc.edu.cn/pypi/web/simple
    fi
    if [[ -z ${PIP_TRUSTED_HOST+x} ]]; then
        export PIP_TRUSTED_HOST=mirrors.ustc.edu.cn
    fi
fi
export UBUNTU_IMAGE=${UBUNTU_IMAGE:-docker.io/library/ubuntu:jammy-20221003}

NINJA_VERSION=${NINJA_VERSION:-$(curl -sL https://api.github.com/repos/ninja-build/ninja/releases/latest | jq -r .tag_name)}
NINJA_VERSION=${NINJA_VERSION:-v1.11.1}
export NINJA_VERSION

MESON_VERSION=${MESON_VERSION:-$(curl -sL https://api.github.com/repos/mesonbuild/meson/releases | jq -r -S ".[].tag_name" | grep -v 'rc' | sort -r | head -n 1)}
MESON_VERSION=${MESON_VERSION:-0.63.3}
export MESON_VERSION

add_image "docker.io/yaekee/vsc-devcontainer-meson:${MESON_VERSION}"
