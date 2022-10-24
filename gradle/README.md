# README

- <https://api.adoptium.net>

```bash
JAVA_URL=$(curl -sL -X GET 'https://api.adoptium.net/v3/assets/feature_releases/17/ga?architecture=x64&heap_size=normal&image_type=jdk&os=linux&page=0&page_size=10&project=jdk&sort_method=DATE&sort_order=DESC&vendor=eclipse' -H 'accept: application/json' | jq -r '.[0].binaries[0].package.link')
mkdir /opt/java
curl -sL "${JAVA_URL}" | tar --strip-components=1 -zxf - -C /opt/java
```

Consider to use <https://hub.docker.com/_/eclipse-temurin>

- `docker.io/library/eclipse-temurin:17.0.4.1_1-jdk`
- `docker.io/library/eclipse-temurin:17.0.4.1_1-jdk-alpine`
- `docker.io/library/eclipse-temurin:17.0.4.1_1-jdk-jammy`
- `docker.io/library/eclipse-temurin:17.0.4.1_1-jdk-focal`
