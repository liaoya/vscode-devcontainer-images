ARG VSC_UBUNTU_IMAGE
#hadolint ignore=DL3006
FROM $VSC_UBUNTU_IMAGE

#hadolint ignore=DL3008
RUN set -eux; \
    apt-get update -y; \
    apt-get install -y --no-install-recommends \
        automake \
        bison \
        build-essential \
        flex \
        pkg-config \
        ; \
    rm -rf /var/lib/apt/lists/*

ARG CMAKE_VERSION
#hadolint ignore=DL4006,SC3057
RUN set -eux; \
    curl -sL -o- "https://github.com/Kitware/CMake/releases/download/${CMAKE_VERSION}/cmake-${CMAKE_VERSION:1}-linux-x86_64.tar.gz" | tar --strip-components=1 -zxf - -C /usr/local; \
    rm -f /usr/local/bin/cmake-gui /usr/local/bin/ccmake; \
    cp /usr/local/share/bash-completion/completions/* /etc/bash_completion.d/

ARG NINJA_VERSION
#hadolint ignore=DL4006
RUN set -eux; \
    curl -sL -o- "https://github.com/ninja-build/ninja/releases/download/${NINJA_VERSION}/ninja-linux.zip" | zcat | sponge /usr/local/bin/ninja; \
    chmod a+x /usr/local/bin/ninja
