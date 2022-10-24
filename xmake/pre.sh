#!/bin/bash

export VSC_UBUNTU_IMAGE=${VSC_UBUNTU_IMAGE:-docker.io/yaekee/vsc-devcontainer-ubuntu:jammy}

XMAKE_VERSION=${XMAKE_VERSION:-$(curl -sL https://api.github.com/repos/xmake-io/xmake/releases/latest | jq -r .tag_name)}
XMAKE_VERSION=${XMAKE_VERSION:-v2.7.2}
export XMAKE_VERSION=${XMAKE_VERSION:1}

add_image "docker.io/yaekee/vsc-devcontainer-xmake:v${XMAKE_VERSION}"
