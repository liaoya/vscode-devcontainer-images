# Thrift

```Dockerfile
#hadolint ignore=DL3008
RUN set -eux; \
    sed -i 's/^# *deb-src/deb-src/g' /etc/apt/sources.list; \
    apt-get update -y; \
    apt-get build-dep -y --no-install-recommends libthrift-dev libthrift-c-glib-dev python3-thrift; \
    rm -rf /var/lib/apt/lists/*

ARG THRIFT_VERSION
RUN set -uex; \
    mkdir -p /tmp/thrift; \
    curl -sL https://dlcdn.apache.org/thrift/${THRIFT_VERSION}/thrift-${THRIFT_VERSION}.tar.gz | tar --strip-components=1 -C /tmp/thrift -zxf -; \
    (cd /tmp/thrift; ./configure --without-go --without-perl --without-php --without-ruby; make -j install-strip)
```

```bash
export http_proxy=http://10.245.250.11:3128
export https_proxy=http://10.245.250.11:1080
export no_proxy=localhost,127.0.0.1,calix.ai,calix.dev,calix.com,calix.local

export DEBIAN_FRONTEND=noninteractive

export UBUNTU_MIRROR_PATH=http://mirrors.ustc.edu.cn

apt list --installed 2>/dev/null | grep -E "^auto"

THRIFT_VERSION=${THRIFT_VERSION:-$(curl -sL https://api.github.com/repos/apache/thrift/releases/latest | jq -r .tag_name)}
THRIFT_VERSION=${THRIFT_VERSION:-v0.17.0}
export THRIFT_VERSION=${THRIFT_VERSION:1}
```

## Issues

Still fail to build php even with the following packages

```bash
apt-get -y --no-install-recommends install composer php php-curl
```
