#!/bin/bash

export VSC_UBUNTU_IMAGE=${VSC_UBUNTU_IMAGE:-docker.io/yaekee/vsc-devcontainer-ubuntu:jammy}

NINJA_VERSION=${NINJA_VERSION:-$(curl -sL https://api.github.com/repos/ninja-build/ninja/releases/latest | jq -r .tag_name)}
NINJA_VERSION=${NINJA_VERSION:-v1.11.1}
export NINJA_VERSION

MESON_VERSION=${MESON_VERSION:-$(curl -sL https://api.github.com/repos/mesonbuild/meson/releases | jq -r -S ".[].tag_name" | grep -v 'rc' | sort -r | head -n 1)}
MESON_VERSION=${MESON_VERSION:-0.63.3}
export MESON_VERSION

#shellcheck disable=SC2086
add_image "docker.io/yaekee/vsc-devcontainer-meson:$(echo ${VSC_UBUNTU_IMAGE} | cut -d: -f2)-${MESON_VERSION}"
add_image "docker.io/yaekee/vsc-devcontainer-meson:${MESON_VERSION}"
add_image docker.io/yaekee/vsc-devcontainer-meson:latest
