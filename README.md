# README

The similar work of devcontainers in <https://github.com/devcontainers/images>

Use these files directly by creating `.devcontainer`, put `Dockerfile` and `devcontainer.json` under it.

## Build

We prefer `http` since it can be cached by squid.

```bash
docker image ls | grep "yaekee/vsc-devcontainer" | tr -s '[:space:]' | cut -d" " -f3 | sort | uniq | xargs docker image rm

./build-docker.sh -w alpine
./build-docker.sh -w debian
./build-docker.sh -w ubuntu
env UBUNTU_IMAGE=docker.io/library/ubuntu:focal-20220922 ./build-docker.sh -w ubuntu

# Disable MIRROR_PATH in China
env ALPINE_MIRROR_PATH= ./build-docker.sh -w alpine
env DEBIAN_MIRROR_PATH= ./build-docker.sh -w debian
env UBUNTU_MIRROR_PATH= ./build-docker.sh -w ubuntu
env UBUNTU_IMAGE=docker.io/library/ubuntu:focal-20220922 UBUNTU_MIRROR_PATH= ./build-docker.sh -w ubuntu

env DEBIAN_MIRROR_PATH= BASE_IMAGE=docker.io/library/debian:bullseye-backports ./build-docker.sh -w debian

# Use http://mirrors.aliyun.com as the mirror server
env ALPINE_MIRROR_PATH=http://mirrors.aliyun.com ./build-docker.sh -w alpine
env DEBIAN_MIRROR_PATH=http://mirrors.aliyun.com ./build-docker.sh -w debian
env UBUNTU_MIRROR_PATH=http://mirrors.aliyun.com ./build-docker.sh -w ubuntu
```

Clean the images

```bash
docker image ls | grep yaekee/vsc-devcontainer | tr -s " " | cut -d" " -f1,2 | sed "s/ /:/g" | xargs docker image rm -f

docker image ls | grep yaekee/vsc-devcontainer | tr -s " " | cut -d" " -f3 | xargs docker image rm -f
```

## Code Snippet to install some static tools

```Dockerfile
RUN set -eux; \
    CMAKE_VERSION=${CMAKE_VERSION:-$(curl -sL https://api.github.com/repos/Kitware/CMake/releases | jq -r -S ".[].tag_name" | grep -v '\-rc' | sort -r | head -n 1)}; \
    CMAKE_VERSION=${CMAKE_VERSION:-v3.25.1}; \
    curl -sL -o- "https://github.com/Kitware/CMake/releases/download/${CMAKE_VERSION}/cmake-${CMAKE_VERSION:1}-linux-x86_64.tar.gz" | tar --strip-components=1 -zxf - -C /usr/local; \
    rm -f /usr/local/bin/cmake-gui /usr/local/bin/ccmake; \
    cp /usr/local/share/bash-completion/completions/* /etc/bash_completion.d/

RUN set -eux; \
    CURLIE_VERSION=${CURLIE_VERSION:-$(curl -sL https://api.github.com/repos/rs/curlie/releases/latest | jq -r .tag_name)}; \
    CURLIE_VERSION=${CURLIE_VERSION:-v1.6.9}; \
    curl -sL -o - "https://github.com/rs/curlie/releases/download/${CURLIE_VERSION}/curlie_${CURLIE_VERSION:1}_linux_amd64.tar.gz" | tar -I gzip -xf - -C /tmp; \
    mv /tmp/curlie /usr/local/bin/curlie

RUN set -eux; \
    GITUI_VERSION=${GITUI_VERSION:-$(curl -sL https://api.github.com/repos/extrawurst/gitui/releases/latest | jq -r .tag_name)}; \
    GITUI_VERSION=${GITUI_VERSION:-v0.21.0}; \
    curl -sL -o - "https://github.com/extrawurst/gitui/releases/download/${GITUI_VERSION}/gitui-linux-musl.tar.gz" | tar -I gzip -xf - -C /usr/local/bin

RUN set -eux; \
    HADOLINT_VERSION=${HADOLINT_VERSION:-$(curl -sL https://api.github.com/repos/hadolint/hadolint/releases/latest | jq -r .tag_name)}; \
    HADOLINT_VERSION=${HADOLINT_VERSION:-v2.10.0}; \
    curl -sL "https://github.com/hadolint/hadolint/releases/download/${HADOLINT_VERSION}/hadolint-Linux-x86_64" -o /usr/local/bin/hadolint; \
    chmod a+x /usr/local/bin/hadolint

RUN set -eux; \
    JP_VERSION=${JP_VERSION:-$(curl -sL https://api.github.com/repos/jmespath/jp/releases/latest | jq -r .tag_name)}; \
    JP_VERSION=${JP_VERSION:-0.2.1}; \
    curl -sL "https://github.com/jmespath/jp/releases/download/${JP_VERSION}/jp-linux-amd64" -o /usr/local/bin/jp; \
    chmod a+x /usr/local/bin/jp

RUN set -eux; \
    JQ_VERSION=${JQ_VERSION:-$(curl -sL https://api.github.com/repos/stedolan/jq/releases/latest | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/')}
    JQ_VERSION=${JQ_VERSION:-jq-1.6}
    curl -sL "https://github.com/stedolan/jq/releases/download/${JQ_VERSION}/jq-linux64" -o /usr/local/jq; \
    chmod a+x /usr/local/jq

RUN set -eux; \
    LAZYGIT_VERSION=${LAZYGIT_VERSION:-$(curl -sL https://api.github.com/repos/jesseduffield/lazygit/releases/latest | jq -r .tag_name)}; \
    LAZYGIT_VERSION=${LAZYGIT_VERSION:-v0.35}; \
    curl -sL -o - "https://github.com/jesseduffield/lazygit/releases/download/${LAZYGIT_VERSION}/lazygit_${LAZYGIT_VERSION:1}_Linux_x86_64.tar.gz" | tar -I gzip -xf - -C /tmp; \
    mv /tmp/lazygit /usr/local/lazygit

RUN set -eux; \
    curl -sL -o /usr/local/bin/muon https://muon.build/releases/v0.1.0/muon-0.1.0-amd64-linux-static-small; \
    curl -sL -o /usr/local/bin/muon-static https://muon.build/releases/v0.1.0/muon-0.1.0-amd64-linux-static; \
    chmod a+x /usr/local/bin/muon-static /usr/local/bin/muon

RUN set -eux; \
    NINJA_VERSION=${NINJA_VERSION:-$(curl -sL https://api.github.com/repos/ninja-build/ninja/releases/latest | jq -r .tag_name)}; \
    NINJA_VERSION=${NINJA_VERSION:-v1.11.1}; \
    curl -sL -o- "https://github.com/ninja-build/ninja/releases/download/${NINJA_VERSION}/ninja-linux.zip" | zcat | sponge /usr/local/bin/ninja; \
    chmod a+x /usr/local/bin/ninja

# Build ninja on alpine
RUN set-eux; \
    NINJA_VERSION=${NINJA_VERSION:-$(curl -sL https://api.github.com/repos/ninja-build/ninja/releases/latest | jq -r .tag_name)}; \
    NINJA_VERSION=${NINJA_VERSION:-v1.11.1}; \
    mkdir -p /tmp/ninja; \
    curl -sL "https://github.com/ninja-build/ninja/archive/refs/tags/${NINJA_VERSION}.tar.gz" | tar --strip-components=1 -C /tmp/ninja -zxf -; \
    cmake -S /tmp/ninja -B /tmp/ninja/build; \
    cmake --build /tmp/ninja/build --target install/strip; \
    rm -fr /tmp/ninja/build

#hadolint ignore=SC2016
RUN set -eux; \
    POWERLINE_GO_VERSION=${POWERLINE_GO_VERSION:-$(curl -sL https://api.github.com/repos/justjanne/powerline-go/releases/latest | jq -r .tag_name)}; \
    curl -sL "https://github.com/justjanne/powerline-go/releases/download/${POWERLINE_GO_VERSION}/powerline-go-linux-amd64" -o /usr/local/bin/powerline-go; \
    chmod a+x /usr/local/bin/powerline-go; \
    echo -e '#!/bin/bash\n\nif command -v powerline-go 1>/dev/null 2>&1 && [[ $TERM == xterm-256 || $TERM != putty-256 ]]; then\n    function _update_ps1() {\n        PS1="$(powerline-go -cwd-max-depth 5 -cwd-max-dir-size 50 -error $? -hostname-only-if-ssh -jobs $(jobs -p | wc -l) -newline)"\n    }\n    if [[ ! $PROMPT_COMMAND =~ _update_ps1 ]]; then\n        PROMPT_COMMAND="_update_ps1; $PROMPT_COMMAND"\n    fi\nfi' >/etc/profile.d/powerline-go.sh

RUN set -eux; \
    RIPGREP_VERSIOIN=${RIPGREP_VERSIOIN:-$(curl -sL https://api.github.com/repos/BurntSushi/ripgrep/releases/latest | jq -r .tag_name)}; \
    RIPGREP_VERSIOIN=${RIPGREP_VERSIOIN:-13.0.0}; \
    mkdir -p /tmp/ripgrep; \
    curl -sL "https://github.com/BurntSushi/ripgrep/releases/download/${RIPGREP_VERSIOIN}/ripgrep-${RIPGREP_VERSIOIN}-x86_64-unknown-linux-musl.tar.gz" -o - | tar --strip-components=1 -Igzip -xf - -C /tmp/ripgrep; \
    mv /tmp/ripgrep/rg /usr/local/bin/rg; \
    chown 0:0 /usr/local/bin/rg; \
    mv -pr /tmp/ripgrep/complete/rg.bash /etc/bash_completion.d/; \
    if command -v fish; then mv /tmp/ripgrep/complete/rg.fish /etc/fish/completions/; fi; \
    rm -fr /tmp/ripgrep

RUN set -eux; \
    RIPGREP_VERSION=$(curl "${CURL_OPTS[@]}" -s -n https://api.github.com/repos/BurntSushi/ripgrep/releases/latest | jq -r '.tag_name'); \
    RIPGREP_VERSION=${RIPGREP_VERSION:-13.0.0}; \
    curl -sL "https://github.com/BurntSushi/ripgrep/releases/download/${RIPGREP_VERSION}/ripgrep_${RIPGREP_VERSION}_amd64.deb" -o "/tmp/ripgrep_${RIPGREP_VERSION}_amd64.deb"; \
    dpkg -i "/tmp/ripgrep_${RIPGREP_VERSION}_amd64.deb"; \
    cp /usr/share/bash-completion/completions/rg /etc/bash_completion.d/rg.bash

RUN set -eux; \
    curl -sL -o - https://github.com/koalaman/shellcheck/releases/download/stable/shellcheck-stable.linux.x86_64.tar.xz | tar --strip-components=1 -Ixz -xf - -C /tmp; \
    mv /tmp/shellcheck /usr/local/bin/shellcheck; \
    chown 0:0 /usr/local/bin/shellcheck

RUN set -eux; \
    SHFMT_VERSION=${SHFMT_VERSION:-$(curl -sL https://api.github.com/repos/mvdan/sh/releases/latest | jq -r .tag_name)}; \
    SHFMT_VERSION=${SHFMT_VERSION:-v3.5.1}; \
    curl -sL "https://github.com/mvdan/sh/releases/download/${SHFMT_VERSION}/shfmt_${SHFMT_VERSION}_linux_amd64" -o /usr/local/shfmt

#hadolint ignore=SC2016,SC3036
RUN set -eux; \
    sh -c "$(curl -fsSL https://starship.rs/install.sh)" -- --yes; \
    echo -e 'command_timeout=1000\n\n[localip]\ndisabled=true\n\n[shell]\ndisabled=false\nstyle="black bold"' >/etc/starship.toml; \
    echo -e '#!/bin/bash\n\nif [[ $TERM != linux && $TERM != vt220 && $(command -v starship) ]]; then\n    eval "$(starship init bash)"\nfi' >/etc/profile.d/starship.sh

RUN set -eux; \
    XH_VERSION=${XH_VERSION:-$(curl -sL https://api.github.com/repos/ducaale/xh/releases/latest | jq -r .tag_name)}; \
    XH_VERSION=${XH_VERSION:-v0.16.1}; \
    curl -o - -sL "https://github.com/ducaale/xh/releases/download/${XH_VERSION}/xh-${XH_VERSION}-x86_64-unknown-linux-musl.tar.gz" | tar --strip-components=1 -I gzip -xf - -C /tmp; \
    mv /tmp/xh /usr/local/bin/xh; \
    mv /tmp/completions/xh.bash /etc/bash_completion.d/; \
    if command -v fish; then mv /tmp/completions/xh.fish /etc/fish/completions/; fi

RUN set -eux; \
    YQ_VERSION=${YQ_VERSION:-$(curl -sL https://api.github.com/repos/mikefarah/yq/releases/latest | jq -r .tag_name)}; \
    YQ_VERSION=${YQ_VERSION:-v4.30.4}; \
    curl -sL "https://github.com/mikefarah/yq/releases/download/${YQ_VERSION}/yq_linux_amd64.tar.gz" -o - | tar -I gzip -xf - -C /tmp; \
    mv /tmp/yq /usr/local/bin/yq; \
    /tmp/install-man-page.sh; \
    yq shell-completion bash >/etc/bash_completion.d/yq; \
    if command -v fish; yq shell-completion fish >/etc/fish/completions/yq.fish; fi
```

## Images

```text
vsc-thrift-missing-guide-53794073be560573c16401627855c1f0-uid   latest                  57fea9e852f9   15 minutes ago      155MB
vsc-thrift-missing-guide-53794073be560573c16401627855c1f0       latest                  7fa078ac0b26   16 minutes ago      155MB
vsc-json-c-317e9ee32c89420a1b5c2ded1a37e4d9-uid                 latest                  fcee1bd49f50   39 minutes ago      428MB
vsc-json-c-317e9ee32c89420a1b5c2ded1a37e4d9                     latest                  0ae8bd5ebad3   39 minutes ago      428MB
```
