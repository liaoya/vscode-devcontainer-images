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
        gdb \
        libboost-dev \
        libglib2.0-dev \
        libssl-dev \
        libtool \
        pkg-config \
        ; \
    rm -rf /var/lib/apt/lists/*

#hadolint ignore=DL3008,DL4006,SC3057
RUN set -eux; \
    CMAKE_VERSION=${CMAKE_VERSION:-$(curl -sL https://api.github.com/repos/Kitware/CMake/releases | jq -r -S ".[].tag_name" | grep -v '\-rc' | sort -r | head -n 1)}; \
    CMAKE_VERSION=${CMAKE_VERSION:-v3.24.2}; \
    curl -sL -o- "https://github.com/Kitware/CMake/releases/download/${CMAKE_VERSION}/cmake-${CMAKE_VERSION:1}-linux-x86_64.tar.gz" | tar --strip-components=1 -zxf - -C /usr/local; \
    rm -f /usr/local/bin/cmake-gui /usr/local/bin/ccmake; \
    cp /usr/local/share/bash-completion/completions/* /etc/bash_completion.d/; \
    NINJA_VERSION=${NINJA_VERSION:-$(curl -sL https://api.github.com/repos/ninja-build/ninja/releases/latest | jq -r .tag_name)}; \
    NINJA_VERSION=${NINJA_VERSION:-v1.11.1}; \
    curl -sL -o- "https://github.com/ninja-build/ninja/releases/download/${NINJA_VERSION}/ninja-linux.zip" | zcat | sponge /usr/local/bin/ninja; \
    chmod a+x /usr/local/bin/ninja

ARG THRIFT_VERSION
#hadolint ignore=DL3003,DL4006
RUN set -uex; \
    mkdir -p /opt/foss/thrift; \
    curl -sL https://dlcdn.apache.org/thrift/${THRIFT_VERSION}/thrift-${THRIFT_VERSION}.tar.gz | tar --strip-components=1 -C /opt/foss/thrift -zxf -; \
    (cd /opt/foss/thrift; ./configure; make -j install-strip; make clean); \
    echo "/usr/local/lib" > /etc/ld.so.conf.d/local.conf; \
    ldconfig
