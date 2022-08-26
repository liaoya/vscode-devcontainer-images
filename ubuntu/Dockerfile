ARG BASE_IMAGE
#hadolint ignore=DL3006
FROM $BASE_IMAGE
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

ENV DEBIAN_FRONTEND=noninteractive

ARG UBUNTU_MIRROR_PATH
RUN set -eux; \
    if [ -f /etc/apt/sources.list.origin ]; then cp -pr /etc/apt/sources.list /etc/apt/sources.list.origin; fi; \
    sed -i -e "s%https://%http://%g" /etc/apt/sources.list; \
    if [ -n "${UBUNTU_MIRROR_PATH}" ]; then \
        sed -i -e "s%http://.*archive.ubuntu.com%${UBUNTU_MIRROR_PATH}%g" \
            -e "s%http://security.ubuntu.com%${UBUNTU_MIRROR_PATH}%g" \
            -e "s%https://.*archive.ubuntu.com%${UBUNTU_MIRROR_PATH}%g" \
            -e "s%https://security.ubuntu.com%${UBUNTU_MIRROR_PATH}%g" \
            -e 's/^deb-src/#deb-src/' /etc/apt/sources.list; \
    fi

# Never put openssh-client otherwise devcontainer will not start up 
#hadolint ignore=DL3008
RUN set -eux; \
    apt-get update -y; \
    apt-get install -y --no-install-recommends \
        apt-utils \
        ca-certificates \
        curl \
        git \
        gnupg2 \
        jq \
        less \
        nano \
        sudo \
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
