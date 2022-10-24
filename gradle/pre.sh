#!/bin/bash

export VSC_UBUNTU_IMAGE=${UBUNTU_IMAGE:-docker.io/yaekee/vsc-devcontainer-ubuntu:jammy-20221003}
export ECLIPSE_TEMURIN_IMAGE=${ECLIPSE_TEMURIN_IMAGE:-docker.io/library/eclipse-temurin:17.0.4.1_1-jdk}
export GRADLE_URL=${GRADLE_URL:-https://services.gradle.org/distributions/gradle-7.5.1-bin.zip}
GRADLE_VERSION=$(echo "${GRADLE_URL}" | rev | cut -d/ -f1 | rev | cut -d- -f2)
JAVA_VERSION=$(echo "${ECLIPSE_TEMURIN_IMAGE}" | cut -d: -f2 | cut -d_ -f1)
add_image "docker.io/yaekee/vsc-devcontainer-gradle:${GRADLE_VERSION}"
add_image "docker.io/yaekee/vsc-devcontainer-gradle:${GRADLE_VERSION}-${JAVA_VERSION}"
