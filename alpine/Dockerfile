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
RUN set -eux; \
    curl -sL https://bootstrap.pypa.io/get-pip.py | python3 -; \
    pip3 install --prefix /usr/local --no-cache-dir pre-commit

#hadolint ignore=SC2016
RUN set -eux; \
    POWERLINE_GO_VERSION=${POWERLINE_GO_VERSION:-$(curl -sL https://api.github.com/repos/justjanne/powerline-go/releases/latest | jq -r .tag_name)}; \
    curl -sL "https://github.com/justjanne/powerline-go/releases/download/${POWERLINE_GO_VERSION}/powerline-go-linux-amd64" -o /usr/local/bin/powerline-go; \
    chmod a+x /usr/local/bin/powerline-go; \
    echo -e '#!/bin/bash\n\nif command -v powerline-go 1>/dev/null 2>&1 && [[ $TERM == xterm-256 || $TERM != putty-256 ]]; then\n    function _update_ps1() {\n        PS1="$(powerline-go -cwd-max-depth 5 -cwd-max-dir-size 50 -error $? -hostname-only-if-ssh -jobs $(jobs -p | wc -l) -newline)"\n    }\n    if [[ ! $PROMPT_COMMAND =~ _update_ps1 ]]; then\n        PROMPT_COMMAND="_update_ps1; $PROMPT_COMMAND"\n    fi\nfi' >/etc/profile.d/powerline-go.sh


ARG USERNAME=vscode
RUN set -eux ; \
    adduser -D -G users -s /bin/bash "${USERNAME}"; \
    echo "${USERNAME}:${USERNAME}" | chpasswd; \
    touch "/home/${USERNAME}/.bashrc"; \
    echo "${USERNAME}    ALL=(ALL)    NOPASSWD: ALL" | tee "/etc/sudoers.d/${USERNAME}"; \
    chmod 0440 "/etc/sudoers.d/${USERNAME}"; \
    mkdir -p "/home/${USERNAME}/.vscode-server/extensions" "/home/${USERNAME}/.vscode-server-insiders/extensions"; \
    chown -R "${USERNAME}:$(id -g ${USERNAME})" "/home/${USERNAME}/.vscode-server" "/home/${USERNAME}/.vscode-server-insiders"
