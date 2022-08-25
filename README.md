# README

Create `.devcontainer`, put `Dockerfile` and `devcontainer.json` under it.

```Dockerfile
RUN set -eux; \
    curl -sL -o - https://github.com/koalaman/shellcheck/releases/download/stable/shellcheck-stable.linux.x86_64.tar.xz | tar --strip-components=1 -Ixz -xf - -C /usr/local/bin; \
    chown 0:0 /usr/local/bin/shellcheck

RUN set -eux; \
    HADOLINT_VERSION=${HADOLINT_VERSION:-$(curl -sL https://api.github.com/repos/hadolint/hadolint/releases/latest | jq -r .tag_name)}; \
    HADOLINT_VERSION=${HADOLINT_VERSION:-v2.10.0}; \
    curl -sL "https://github.com/hadolint/hadolint/releases/download/${HADOLINT_VERSION}/hadolint-Linux-x86_64" -o /usr/local/bin/hadolint; \
    chmod a+x /usr/local/bin/hadolint

RUN set -eux; \
    RIPGREP_VERSIOIN=${RIPGREP_VERSIOIN:-$(curl -sL https://api.github.com/repos/BurntSushi/ripgrep/releases/latest | jq -r .tag_name)}; \
    RIPGREP_VERSIOIN=${RIPGREP_VERSIOIN:-13.0.0}; \
    curl -sL "https://github.com/BurntSushi/ripgrep/releases/download/${RIPGREP_VERSIOIN}/ripgrep-${RIPGREP_VERSIOIN}-x86_64-unknown-linux-musl.tar.gz" -o - | tar --strip-components=1 -Igzip -xf - -C /usr/local/bin; \
    chown 0:0 /usr/local/bin/rg; \
    cp -pr rg.bash /etc/bash_completion.d/
```

```text
vsc-thrift-missing-guide-53794073be560573c16401627855c1f0-uid   latest                  57fea9e852f9   15 minutes ago      155MB
vsc-thrift-missing-guide-53794073be560573c16401627855c1f0       latest                  7fa078ac0b26   16 minutes ago      155MB
vsc-json-c-317e9ee32c89420a1b5c2ded1a37e4d9-uid                 latest                  fcee1bd49f50   39 minutes ago      428MB
vsc-json-c-317e9ee32c89420a1b5c2ded1a37e4d9                     latest                  0ae8bd5ebad3   39 minutes ago      428MB
```
