ARG VSC_CMAKE_IMAGE
#hadolint ignore=DL3006
FROM $VSC_CMAKE_IMAGE

ARG LIBWEBSOCKETS_VERSION
#hadolint ignore=DL4006
RUN set -eux; \
    mkdir /opt/foss/libwebsockets /tmp/build; \
    curl -sL "https://github.com/warmcat/libwebsockets/archive/refs/tags/${LIBWEBSOCKETS_VERSION}.tar.gz" | tar --strip-components=1 -C /opt/foss/libwebsockets -zxf -; \
    cmake -S /opt/foss/libwebsockets -B /tmp/build; \
    cmake --build /tmp/build --target install; \
    rm -fr /tmp/build; \
    echo "/usr/local/lib" > /etc/ld.so.conf.d/local.conf; \
    ldconfig
