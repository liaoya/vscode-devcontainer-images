# README

Use these files directly by creating `.devcontainer`, put `Dockerfile` and `devcontainer.json` under it.

## Build

We prefer `http` since it can be cached by squid.

```bash
./build-docker.sh -w alpine
./build-docker.sh -w debian
./build-docker.sh -w ubuntu

# Use http://mirrors.ustc.edu.cn as the mirror server
env ALPINE_MIRROR_PATH= ./build-docker.sh -w alpine
env DEBIAN_MIRROR_PATH= ./build-docker.sh -w debian
env UBUNTU_MIRROR_PATH= ./build-docker.sh -w ubuntu

env DEBIAN_MIRROR_PATH= BASE_IMAGE=docker.io/library/debian:bullseye-backports ./build-docker.sh -w debian

# Use http://mirrors.aliyun.com as the mirror server
env ALPINE_MIRROR_PATH=http://mirrors.aliyun.com ./build-docker.sh -w alpine
env DEBIAN_MIRROR_PATH=http://mirrors.aliyun.com ./build-docker.sh -w debian
env UBUNTU_MIRROR_PATH=http://mirrors.aliyun.com ./build-docker.sh -w ubuntu
```

Clean the images

```bash
docker image ls | grep yaekee/devcontainer-base | tr -s " " | cut -d" " -f1,2 | tr " " ":" | xargs docker image rm -f

docker image ls | grep yaekee/devcontainer-base | tr -s " " | cut -d" " -f3 | xargs docker image rm -f
```

## Code Snippet to install some static tools

```Dockerfile
RUN set -eux; \
    CMAKE_VERSION=${CMAKE_VERSION:-$(curl -sL https://api.github.com/repos/Kitware/CMake/releases | jq -r -S ".[].tag_name" | grep -v '\-rc' | head -n 1)}; \
    CMAKE_VERSION=${CMAKE_VERSION:-v3.24.1}; \
    curl -sL -o- "https://github.com/Kitware/CMake/releases/download/${CMAKE_VERSION}/cmake-${CMAKE_VERSION:1}-linux-x86_64.tar.gz" | sudo tar --strip-components=1 -zxf - -C /usr/local; \
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
    NINJA_VERSION=${NINJA_VERSION:-curl -sL https://api.github.com/repos/ninja-build/ninja/releases/latest | jq -r .tag_name}; \
    NINJA_VERSION=${NINJA_VERSION:-v1.11.0}; \
    curl -sL -o- "https://github.com/ninja-build/ninja/releases/download/${NINJA_VERSION}/ninja-linux.zip" | zcat | sponge /usr/local/bin/ninja; \
    chmod a+x /usr/local/bin/ninja

RUN set -eux; \
    RIPGREP_VERSIOIN=${RIPGREP_VERSIOIN:-$(curl -sL https://api.github.com/repos/BurntSushi/ripgrep/releases/latest | jq -r .tag_name)}; \
    RIPGREP_VERSIOIN=${RIPGREP_VERSIOIN:-13.0.0}; \
    curl -sL "https://github.com/BurntSushi/ripgrep/releases/download/${RIPGREP_VERSIOIN}/ripgrep-${RIPGREP_VERSIOIN}-x86_64-unknown-linux-musl.tar.gz" -o - | tar --strip-components=1 -Igzip -xf - -C /tmp; \
    mv /tmp/rg /usr/local/bin/rg; \
    chown 0:0 /usr/local/bin/rg; \
    mv -pr /tmp/complete/rg.bash /etc/bash_completion.d/; \
    if command -v fish; then mv /tmp/complete/rg.fish /etc/fish/completions/; fi; \
    rm -fr /usr/local/bin/complete

RUN set -eux; \
    curl -sL -o - https://github.com/koalaman/shellcheck/releases/download/stable/shellcheck-stable.linux.x86_64.tar.xz | tar --strip-components=1 -Ixz -xf - -C /tmp; \
    mv /tmp/shellcheck /usr/local/bin/shellcheck; \
    chown 0:0 /usr/local/bin/shellcheck

RUN set -eux; \
    SHFMT_VERSION=${SHFMT_VERSION:-$(curl -sL https://api.github.com/repos/mvdan/sh/releases/latest | jq -r .tag_name)}; \
    SHFMT_VERSION=${SHFMT_VERSION:-v3.5.1}; \
    curl -sL "https://github.com/mvdan/sh/releases/download/${SHFMT_VERSION}/shfmt_${SHFMT_VERSION}_linux_amd64" -o /usr/local/shfmt

RUN set -eux; \
    XH_VERSION=${XH_VERSION:-$(curl -sL https://api.github.com/repos/ducaale/xh/releases/latest | jq -r .tag_name)}; \
    XH_VERSION=${XH_VERSION:-v0.16.1}; \
    curl -o - -sL "https://github.com/ducaale/xh/releases/download/${XH_VERSION}/xh-${XH_VERSION}-x86_64-unknown-linux-musl.tar.gz" | tar --strip-components=1 -I gzip -xf - -C /tmp; \
    mv /tmp/xh /usr/local/bin/xh; \
    mv /tmp/completions/xh.bash /etc/bash_completion.d/; \
    if command -v fish; then mv /tmp/completions/xh.fish /etc/fish/completions/; fi

RUN set -eux; \
    YQ_VERSION=${YQ_VERSION:-$(curl -sL https://api.github.com/repos/mikefarah/yq/releases/latest | jq -r .tag_name)}; \
    YQ_VERSION=${YQ_VERSION:-v4.27.2}; \
    curl -sL "https://github.com/mikefarah/yq/releases/download/${YQ_VERSION}/yq_linux_amd64.tar.gz" -o - | tar -I gzip -xf - -C /tmp; \
    mv /tmp/yq /usr/local/bin/yq; \
    /tmp/install-man-page.sh; \
    yq shell-completion bash >/etc/bash_completion.d/yq; \
    if command -v fish; yq shell-completion fish >/etc/fish/completions/yq.fish; fi
```

## Install Python package via PIP

The following is complete example

```Dockerfile
ARG PIP_INDEX_URL
ARG PIP_TRUSTED_HOST
#hadolint ignore=DL3013
RUN set -ex; \
    curl -sL https://bootstrap.pypa.io/get-pip.py | python3 - ; \
    pip install --no-cache-dir ansible-core ansible-lint robotframework robotframework-robocop rf-lint
```

```bash
# For ansible
pip install --no-cache-dir ansible-core ansible-lint

# For robot framework
pip install --no-cache-dir robotframework robotframework-robocop rf-lint
```

## Images

```text
vsc-thrift-missing-guide-53794073be560573c16401627855c1f0-uid   latest                  57fea9e852f9   15 minutes ago      155MB
vsc-thrift-missing-guide-53794073be560573c16401627855c1f0       latest                  7fa078ac0b26   16 minutes ago      155MB
vsc-json-c-317e9ee32c89420a1b5c2ded1a37e4d9-uid                 latest                  fcee1bd49f50   39 minutes ago      428MB
vsc-json-c-317e9ee32c89420a1b5c2ded1a37e4d9                     latest                  0ae8bd5ebad3   39 minutes ago      428MB
```
