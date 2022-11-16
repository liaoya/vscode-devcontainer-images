ARG VSC_UBUNTU_IMAGE
#hadolint ignore=DL3006
FROM $VSC_UBUNTU_IMAGE

#hadolint ignore=DL3008
RUN set -eux; \
    apt-get update -y; \
    apt-get install -y --no-install-recommends \
        build-essential \
        pkg-config \
        python3 \
        ; \
    rm -rf /var/lib/apt/lists/*

ARG NINJA_VERSION
#hadolint ignore=DL4006
RUN set -eux; \
    curl -sL -o- "https://github.com/ninja-build/ninja/releases/download/${NINJA_VERSION}/ninja-linux.zip" | zcat | sponge /usr/local/bin/ninja; \
    chmod a+x /usr/local/bin/ninja

ARG MESON_VERSION
#hadolint ignore=DL4006
RUN set -eux; \
    pip3 install --no-cache-dir "meson==${MESON_VERSION}"
