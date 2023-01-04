#!/bin/bash

if [[ $(timedatectl show | grep Timezone | cut -d= -f2) == "Asia/Shanghai" ]]; then
    if [[ -z ${DEBIAN_MIRROR_PATH+x} ]]; then
        export DEBIAN_MIRROR_PATH=http://mirrors.ustc.edu.cn
    fi
fi
export DEBIAN_IMAGE=${DEBIAN_IMAGE:-docker.io/library/debian:stable-20221219-slim}
DEBIAN_VERSION=$(echo "${DEBIAN_IMAGE}" | cut -d":" -f2)
add_image "docker.io/yaekee/vsc-devcontainer-debian:${DEBIAN_VERSION}"
