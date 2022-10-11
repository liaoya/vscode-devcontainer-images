#!/bin/bash

if [[ $(timedatectl show | grep Timezone | cut -d= -f2) == "Asia/Shanghai" ]]; then
    if [[ -z ${ALPINE_MIRROR_PATH+x} ]]; then
        export ALPINE_MIRROR_PATH=http://mirrors.ustc.edu.cn
    fi
fi
export ALPINE_IMAGE=${ALPINE_IMAGE:-docker.io/library/alpine:3.16.2}
ALPINE_VERSION=$(echo "${ALPINE_IMAGE}" | cut -d":" -f2)
add_image "docker.io/yaekee/vsc-devcontainer-alpine:${ALPINE_VERSION}"
