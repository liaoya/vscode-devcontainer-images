#!/bin/bash

export VSC_UBUNTU_IMAGE=${VSC_UBUNTU_IMAGE:-docker.io/yaekee/vsc-devcontainer-ubuntu:jammy}
SDKMAN_VERSION=${SDKMAN_VERSION:-curl -sL https://api.github.com/repos/sdkman/sdkman-cli/releases/latest | jq -r .tag_name}
SDKMAN_VERSION=${SDKMAN_VERSION:-5.16.0}

#shellcheck disable=SC2086
add_image "docker.io/yaekee/vsc-devcontainer-sdkman:$(echo ${VSC_UBUNTU_IMAGE} | cut -d: -f2)-${SDKMAN_VERSION}"
add_image "docker.io/yaekee/vsc-devcontainer-sdkman:${SDKMAN_VERSION}"
