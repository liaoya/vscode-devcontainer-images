#!/bin/bash

export VSC_UBUNTU_IMAGE=${VSC_UBUNTU_IMAGE:-docker.io/yaekee/vsc-devcontainer-ubuntu:jammy-20221003}

CMAKE_VERSION=${CMAKE_VERSION:-$(curl -sL https://api.github.com/repos/Kitware/CMake/releases | jq -r -S ".[].tag_name" | grep -v '\-rc' | sort -r | head -n 1)}
CMAKE_VERSION=${CMAKE_VERSION:-v3.24.2}
export CMAKE_VERSION

NINJA_VERSION=${NINJA_VERSION:-$(curl -sL https://api.github.com/repos/ninja-build/ninja/releases/latest | jq -r .tag_name)}
NINJA_VERSION=${NINJA_VERSION:-v1.11.1}
export NINJA_VERSION

add_image "docker.io/yaekee/vsc-devcontainer-cmake:${CMAKE_VERSION}"
