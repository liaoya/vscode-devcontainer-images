#!/bin/bash

export VSC_CMAKE_IMAGE=${VSC_UBUNTU_IMAGE:-docker.io/yaekee/vsc-devcontainer-cmake:v3.25.1}
export LIBWEBSOCKETS_VERSION=${LIBWEBSOCKETS_VERSION:-v4.0.7}
add_image "docker.io/yaekee/vsc-devcontainer-libwebsocket:${LIBWEBSOCKETS_VERSION}"
