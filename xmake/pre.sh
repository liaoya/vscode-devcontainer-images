#!/bin/bash

export VSC_UBUNTU_IMAGE=${VSC_UBUNTU_IMAGE:-docker.io/yaekee/vsc-devcontainer-ubuntu:jammy}

XMAKE_VERSION=${XMAKE_VERSION:-$(curl -sL https://api.github.com/repos/xmake-io/xmake/releases/latest | jq -r .tag_name)}
XMAKE_VERSION=${XMAKE_VERSION:-v2.7.2}
export XMAKE_VERSION=${XMAKE_VERSION:1}

#shellcheck disable=SC2086
add_image "docker.io/yaekee/vsc-devcontainer-xmake:$(echo ${VSC_UBUNTU_IMAGE} | cut -d: -f2)-${XMAKE_VERSION}"
add_image "docker.io/yaekee/vsc-devcontainer-xmake:${XMAKE_VERSION}"
add_image docker.io/yaekee/vsc-devcontainer-xmake:latest
