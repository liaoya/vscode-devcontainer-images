# README

```bash
env ALPINE_MIRROR_PATH="" ../build-docker.sh -w .

# Push the image
env ALPINE_MIRROR_PATH="" ../build-docker.sh -p -w .

env ALPINE_MIRROR_PATH="" ALPINE_IMAGE=docker.io/library/alpine:3.13.12 ../build-docker.sh -w .
```
