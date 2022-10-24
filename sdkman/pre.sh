#!/bin/bash

export VSC_UBUNTU_IMAGE=${UBUNTU_IMAGE:-docker.io/yaekee/vsc-devcontainer-ubuntu:jammy}
SDKMAN_VERSION=${SDKMAN_VERSION:-curl -sL https://api.github.com/repos/sdkman/sdkman-cli/releases/latest | jq -r .tag_name}
SDKMAN_VERSION=${SDKMAN_VERSION:-5.16.0}
add_image "docker.io/yaekee/vsc-devcontainer-sdkman:${SDKMAN_VERSION}"
