#!/bin/bash

export BASE_IMAGE=${BASE_IMAGE:-docker.io/library/debian:bullseye}
export DEBIAN_MIRROR_PATH=${DEBIAN_MIRROR_PATH:-http://mirrors.ustc.edu.cn}
add_image docker.io/yaekee/devcontainer-base:debian-bullseye