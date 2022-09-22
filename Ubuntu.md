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
