# Ubuntu Code Snippet

```Dockerfile
RUN set -ex; \
    apt-get update -y; \
    apt-get install -y --no-install-recommends \
        build-essential \
        cmake \
        gdb \
        ; \
    rm -rf /var/lib/apt/lists/*
```

- `docker.io/library/ubuntu:jammy-20221003`
- `docker.io/library/ubuntu:focal-20220922`
