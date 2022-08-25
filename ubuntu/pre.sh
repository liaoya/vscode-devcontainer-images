#!/bin/bash

export BASE_IMAGE=${BASE_IMAGE:-docker.io/library/ubuntu:22.04}
export UBUNTU_MIRROR_PATH=${UBUNTU_MIRROR_PATH:-http://mirrors.ustc.edu.cn}
add_image docker.io/yaekee/devcontainer-base:ubuntu-22.04