# README

```bash
env ALPINE_MIRROR_PATH="" ../build-docker.sh -w .
docker image push docker.io/yaekee/vsc-devcontainer-alpine:3.17.0

env ALPINE_MIRROR_PATH="" ALPINE_IMAGE=docker.io/library/alpine:3.13.12 ../build-docker.sh -w .
```
