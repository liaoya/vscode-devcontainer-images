#!/bin/bash

if [[ $(timedatectl show | grep Timezone | cut -d= -f2) == "Asia/Shanghai" ]]; then
    if [[ -z ${DEBIAN_MIRROR_PATH+x} ]]; then
        export DEBIAN_MIRROR_PATH=http://mirrors.ustc.edu.cn
    fi
fi
export BASE_IMAGE=${BASE_IMAGE:-docker.io/library/debian:stable-20220912-slim}
DEBIAN_VERSION=$(echo "${BASE_IMAGE}" | cut -d":" -f2)
add_image "docker.io/yaekee/vsc-devcontainer-base:debian-${DEBIAN_VERSION}"
