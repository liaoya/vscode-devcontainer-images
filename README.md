# README

Create `.devcontainer`, put `Dockerfile` and `devcontainer.json` under it.

```Dockerfile
RUN set -ex; \
    curl -sL -o - https://github.com/koalaman/shellcheck/releases/download/stable/shellcheck-stable.linux.x86_64.tar.xz | tar --strip-components=1 -Ixz -xf - -C /usr/local/bin; \
    chown 0:0 /usr/local/bin/shellcheck

RUN set -ex; \
    HADOLINT_VERSION=${HADOLINT_VERSION:-$(curl -sL https://api.github.com/repos/hadolint/hadolint/releases/latest | jq -r .tag_name)}; \
    HADOLINT_VERSION=${HADOLINT_VERSION:-v2.10.0}; \
    curl -sL "https://github.com/hadolint/hadolint/releases/download/${HADOLINT_VERSION}/hadolint-Linux-x86_64" -o /usr/local/bin/hadolint; \
    chmod a+x /usr/local/bin/hadolint
```

```text
vsc-thrift-missing-guide-53794073be560573c16401627855c1f0-uid   latest                  57fea9e852f9   15 minutes ago      155MB
vsc-thrift-missing-guide-53794073be560573c16401627855c1f0       latest                  7fa078ac0b26   16 minutes ago      155MB
vsc-json-c-317e9ee32c89420a1b5c2ded1a37e4d9-uid                 latest                  fcee1bd49f50   39 minutes ago      428MB
vsc-json-c-317e9ee32c89420a1b5c2ded1a37e4d9                     latest                  0ae8bd5ebad3   39 minutes ago      428MB
```
