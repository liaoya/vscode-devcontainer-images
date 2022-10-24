#!/bin/bash

export VSC_UBUNTU_IMAGE=${UBUNTU_IMAGE:-docker.io/yaekee/vsc-devcontainer-ubuntu:jammy}

THRIFT_VERSION=${THRIFT_VERSION:-$(curl -sL https://api.github.com/repos/apache/thrift/releases/latest | jq -r .tag_name)}
THRIFT_VERSION=${THRIFT_VERSION:-v0.17.0}
export THRIFT_VERSION=${THRIFT_VERSION:1}

add_image "docker.io/yaekee/vsc-devcontainer-thrift:${THRIFT_VERSION}"
