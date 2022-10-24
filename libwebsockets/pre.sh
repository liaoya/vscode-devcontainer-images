#!/bin/bash

export VSC_UBUNTU_IMAGE=${UBUNTU_IMAGE:-docker.io/yaekee/vsc-devcontainer-ubuntu:jammy}
export LIBWEBSOCKETS_VERSION=${LIBWEBSOCKETS_VERSION:-v4.0.7}
add_image "docker.io/yaekee/vsc-devcontainer-libwebsocket:${LIBWEBSOCKETS_VERSION}"
