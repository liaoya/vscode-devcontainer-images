ARG ALPINE_IMAGE
#hadolint ignore=DL3006
FROM $ALPINE_IMAGE
SHELL ["/bin/ash", "-o", "pipefail", "-c"]

ARG ALPINE_MIRROR_PATH=""
RUN set -eux; \
    if [ -f /etc/apk/repositories.origin ]; then cp -pr /etc/apk/repositories /etc/apk/repositories.origin; fi; \
    sed -i -e "s%https://%http://%g" /etc/apk/repositories; \
    if [ -n "${ALPINE_MIRROR_PATH}" ]; then \
        sed -e "s%http://dl-cdn.alpinelinux.org%${ALPINE_MIRROR_PATH}%g" \
            -e "s%https://dl-cdn.alpinelinux.org%${ALPINE_MIRROR_PATH}%g" \
            -i /etc/apk/repositories; \
    fi

# libgcc and libstdc++ is required by vscode-server
# hadolint ignore=DL3018
RUN set -eux ; \
    apk update -q --no-progress ; \
    apk --no-cache --no-progress add \
        bash \
        bzip2 \
        ca-certificates \
        curl \
        file \
        git \
        gzip \
        jq \
        less \
        libgcc \
        libstdc++ \
        moreutils \
        nano \
        python3 \
        sudo \
        tar \
        unzip \
        xz \
        zip \
    ; \
    rm -rf /var/lib/apk/lists/*; \
    rm /var/cache/apk/*

#hadolint ignore=DL3013
RUN set -ex; \
    curl -sL https://bootstrap.pypa.io/get-pip.py | python3 -; \
    pip3 install --no-cache-dir pre-commit

ARG USERNAME=alpine
RUN set -eux ; \
    adduser -D -G users -s /bin/bash "${USERNAME}"; \
    echo "${USERNAME}:${USERNAME}" | chpasswd; \
    touch "/home/${USERNAME}/.bashrc"; \
    echo "${USERNAME}    ALL=(ALL)    NOPASSWD: ALL" | tee "/etc/sudoers.d/${USERNAME}"; \
    chmod 0440 "/etc/sudoers.d/${USERNAME}"; \
    mkdir -p "/home/${USERNAME}/.vscode-server/extensions" "/home/${USERNAME}/.vscode-server-insiders/extensions"; \
    chown -R "${USERNAME}:$(id -g ${USERNAME})" "/home/${USERNAME}/.vscode-server" "/home/${USERNAME}/.vscode-server-insiders"
