#!/bin/bash

if [[ $(timedatectl show | grep Timezone | cut -d= -f2) == "Asia/Shanghai" ]]; then
    if [[ -z ${UBUNTU_MIRROR_PATH+x} ]]; then
        export UBUNTU_MIRROR_PATH=http://mirrors.ustc.edu.cn
    fi
fi
export UBUNTU_IMAGE=${UBUNTU_IMAGE:-docker.io/library/ubuntu:jammy-20221003}

CMAKE_VERSION=${CMAKE_VERSION:-$(curl -sL https://api.github.com/repos/Kitware/CMake/releases | jq -r -S ".[].tag_name" | grep -v '\-rc' | sort -r | head -n 1)}
CMAKE_VERSION=${CMAKE_VERSION:-v3.24.2}
export CMAKE_VERSION

NINJA_VERSION=${NINJA_VERSION:-$(curl -sL https://api.github.com/repos/ninja-build/ninja/releases/latest | jq -r .tag_name)}
NINJA_VERSION=${NINJA_VERSION:-v1.11.1}
export NINJA_VERSION

add_image "docker.io/yaekee/vsc-devcontainer-cmake:${CMAKE_VERSION}"
