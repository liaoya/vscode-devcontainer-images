ARG VSC_UBUNTU_IMAGE
#hadolint ignore=DL3006
FROM $VSC_UBUNTU_IMAGE

#hadolint ignore=DL3008,DL4006
RUN set -ex; \
    apt-get update -y; \
    apt-get install -y --no-install-recommends \
        build-essential \
        pkg-config \
        ; \
    apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys C8CA50B566BFBA052B13B9A770AF26A4DCBD1EB4; \
    echo "deb https://ppa.launchpadcontent.net/xmake-io/xmake/ubuntu/ $(grep UBUNTU_CODENAME /etc/os-release | cut -d= -f2) main" >/etc/apt/sources.list.d/xmake-io-ubuntu-xmake.list; \
    apt-get update -y; \
    apt-get install -y --no-install-recommends xmake; \
    rm -rf /var/lib/apt/lists/*
