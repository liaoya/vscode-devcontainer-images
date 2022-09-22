# Python Code Snippet

The following is complete example

## Ubuntu

```Dockerfile
RUN set -ex; \
    apt-get update -y; \
    apt-get install -y --no-install-recommends \
        build-essential \
        pkg-config \
        python3 \
        python3-dev \
        ; \
    rm -rf /var/lib/apt/lists/*

ARG PIP_INDEX_URL
ARG PIP_TRUSTED_HOST
#hadolint ignore=DL3013
RUN set -ex; \
    curl -sL https://bootstrap.pypa.io/get-pip.py | python3 - ; \
    pip install --no-cache-dir ansible-core ansible-lint robotframework robotframework-robocop rf-lint
```

A more complex examples

```Dockerfile
#hadolint ignore=DL3008
RUN set -ex; \
    apt-get update -y; \
    apt-get install -y --no-install-recommends \
        build-essential \
        libvirt-dev \
        libxml2-dev \
        libxslt-dev \
        pkg-config \
        python3 \
        python3-dev \
        ; \
    rm -rf /var/lib/apt/lists/*

ARG PIP_INDEX_URL
ARG PIP_TRUSTED_HOST
#hadolint ignore=DL3013
RUN set -ex; \
    curl -sL https://bootstrap.pypa.io/get-pip.py | python3 - ; \
    pip install --no-cache-dir ansible-core ansible-lint \
        robotframework robotframework-robocop robotframework-tidy rf-lint \
        decorator timeout_decorator libvirt-python lxml \
        pylint pytest yapf
```

```bash
# For ansible
pip install --no-cache-dir ansible-core ansible-lint

# For robot framework
pip install --no-cache-dir robotframework robotframework-robocop rf-lint
```
