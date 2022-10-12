ARG UBUNTU_IMAGE
#hadolint ignore=DL3006
FROM $UBUNTU_IMAGE
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

ENV DEBIAN_FRONTEND=noninteractive

ARG UBUNTU_MIRROR_PATH
RUN set -eux; \
    if [ -f /etc/apt/sources.list.origin ]; then cp -pr /etc/apt/sources.list /etc/apt/sources.list.origin; fi; \
    sed -i -e "s%https://%http://%g" /etc/apt/sources.list; \
    if [ -n "${UBUNTU_MIRROR_PATH}" ]; then \
        sed -e "s%http://.*archive.ubuntu.com%${UBUNTU_MIRROR_PATH}%g" \
            -e "s%http://security.ubuntu.com%${UBUNTU_MIRROR_PATH}%g" \
            -e "s%https://.*archive.ubuntu.com%${UBUNTU_MIRROR_PATH}%g" \
            -e "s%https://security.ubuntu.com%${UBUNTU_MIRROR_PATH}%g" \
            -e 's/^deb-src/#deb-src/' \
            -i /etc/apt/sources.list; \
    fi

# Never put openssh-client otherwise devcontainer will not start up
#hadolint ignore=DL3008
RUN set -eux; \
    apt-get update -y; \
    apt-get install -y --no-install-recommends \
        apt-utils \
        bzip2 \
        ca-certificates \
        curl \
        git \
        gnupg2 \
        jq \
        less \
        moreutils \
        nano \
        sudo \
        xz-utils \
        ; \
    rm -rf /var/lib/apt/lists/*

ARG USERNAME=ubuntu
RUN set -eux; \
    useradd -g users -m -s /bin/bash "${USERNAME}"; \
    echo "${USERNAME}:${USERNAME}" | chpasswd; \
    echo "${USERNAME}    ALL=(ALL)    NOPASSWD: ALL" | tee "/etc/sudoers.d/${USERNAME}"; \
    chmod 0440 "/etc/sudoers.d/${USERNAME}"; \
    mkdir -p "/home/${USERNAME}/.vscode-server/extensions" "/home/${USERNAME}/.vscode-server-insiders/extensions"; \
    chown -R "${USERNAME}:$(id -g ${USERNAME})" "/home/${USERNAME}/.vscode-server" "/home/${USERNAME}/.vscode-server-insiders"

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
    apt-get build-dep -y libwebsockets; \
    rm -rf /var/lib/apt/lists/*

ARG LIBWEBSOCKETS_VERSION
RUN set -eux; \
    mkdir /tmp/libwebsockets /tmp/build; \
    curl -sL "https://github.com/warmcat/libwebsockets/archive/refs/tags/${LIBWEBSOCKETS_VERSION}.tar.gz" | tar --strip-components=1 -C /tmp/libwebsockets -zxf -; \
    cmake -S /tmp/libwebsockets -B /tmp/build; \
    cmake --build /tmp/build --target install; \
    rm -fr /tmp/libwebsockets /tmp/build; \
    echo "/usr/local/lib" > /etc/ld.so.conf.d/local.conf; \
    ldconfig
