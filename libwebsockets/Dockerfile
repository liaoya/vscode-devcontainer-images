ARG VSC_UBUNTU_IMAGE
#hadolint ignore=DL3006
FROM $VSC_UBUNTU_IMAGE

#hadolint ignore=DL3008
RUN set -eux; \
    sed -i 's/^# *deb-src/deb-src/g' /etc/apt/sources.list; \
    apt-get update -y; \
    apt-get install -y --no-install-recommends \
        build-essential \
        cmake \
        ninja-build \
        pkg-config \
        ; \
    apt-get build-dep -y --no-install-recommends libwebsockets; \
    rm -rf /var/lib/apt/lists/*

ARG LIBWEBSOCKETS_VERSION
#hadolint ignore=DL4006
RUN set -eux; \
    mkdir /tmp/libwebsockets /tmp/build; \
    curl -sL "https://github.com/warmcat/libwebsockets/archive/refs/tags/${LIBWEBSOCKETS_VERSION}.tar.gz" | tar --strip-components=1 -C /tmp/libwebsockets -zxf -; \
    cmake -S /tmp/libwebsockets -B /tmp/build; \
    cmake --build /tmp/build --target install; \
    rm -fr /tmp/libwebsockets /tmp/build; \
    echo "/usr/local/lib" > /etc/ld.so.conf.d/local.conf; \
    ldconfig
