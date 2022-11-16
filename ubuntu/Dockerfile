ARG UBUNTU_IMAGE
#hadolint ignore=DL3006
FROM $UBUNTU_IMAGE
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

ENV DEBIAN_FRONTEND=noninteractive

ARG UBUNTU_MIRROR_PATH=""
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
        ca-certificates \
        gnupg2 \
        ; \
    apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys E996735927E427A733BB653E374C7797FB006459; \
    echo "deb http://ppa.launchpad.net/savoury1/backports/ubuntu $(grep UBUNTU_CODENAME /etc/os-release | cut -d= -f2) main" > /etc/apt/sources.list.d/ppa_savoury1_backports.list; \
    apt-get update -y; \
    apt-get install -y --no-install-recommends \
        apt-utils \
        bzip2 \
        curl \
        file \
        git \
        jq \
        less \
        moreutils \
        nano \
        python3 \
        python3-distutils \
        sudo \
        unzip \
        xz-utils \
        ; \
    rm -rf /var/lib/apt/lists/*

#hadolint ignore=DL3013
RUN set -eux; \
    curl -sL https://bootstrap.pypa.io/get-pip.py | python3 -; \
    pip3 install --prefix /usr/local --no-cache-dir pre-commit

ARG USERNAME=vscode
RUN set -eux; \
    useradd -g users -m -s /bin/bash "${USERNAME}"; \
    echo "${USERNAME}:${USERNAME}" | chpasswd; \
    echo "${USERNAME}    ALL=(ALL)    NOPASSWD: ALL" | tee "/etc/sudoers.d/${USERNAME}"; \
    chmod 0440 "/etc/sudoers.d/${USERNAME}"; \
    mkdir -p "/home/${USERNAME}/.vscode-server/extensions" "/home/${USERNAME}/.vscode-server-insiders/extensions"; \
    chown -R "${USERNAME}:$(id -g ${USERNAME})" "/home/${USERNAME}/.vscode-server" "/home/${USERNAME}/.vscode-server-insiders"
