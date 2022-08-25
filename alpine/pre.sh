#!/bin/bash

export ALPINE_MIRROR_PATH=${ALPINE_MIRROR_PATH:-http://mirrors.ustc.edu.cn}
export BASE_IMAGE=${BASE_IMAGE:-docker.io/library/alpine:3.16.2}
add_image docker.io/yaekee/devcontainer-base:alpine-3.16.2