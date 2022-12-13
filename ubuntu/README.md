# Ubuntu Code Snippet

```bash
env UBUNTU_MIRROR_PATH="" ../build-docker.sh -w .
docker image push docker.io/yaekee/vsc-devcontainer-ubuntu

env ALPINE_MIRROR_PATH="" ALPINE_IMAGE=docker.io/library/alpine:3.13.12 ../build-docker.sh -w .
```

```Dockerfile
RUN set -eux; \
    apt-get update -y; \
    apt-get install -y --no-install-recommends \
        build-essential \
        cmake \
        gdb \
        ; \
    rm -rf /var/lib/apt/lists/*
```

- `docker.io/library/ubuntu:jammy-20221130`
- `docker.io/library/ubuntu:focal-20221130`
- `docker.io/library/ubuntu:bionic-20221130`

## Reference

Don't forget add a file under `/etc/ld.so.conf.d` to avoid set `LD_LIBRARY_PATH` <https://stackoverflow.com/questions/13428910/how-to-set-the-environmental-variable-ld-library-path-in-linux>
