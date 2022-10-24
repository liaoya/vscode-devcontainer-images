ARG ECLIPSE_TEMURIN_IMAGE
ARG VSC_UBUNTU_IMAGE

#hadolint ignore=DL3006
FROM $ECLIPSE_TEMURIN_IMAGE AS eclipse_jdk

#hadolint ignore=DL3006
FROM $VSC_UBUNTU_IMAGE

ENV JAVA_HOME=/opt/java/openjdk \
    GRADLE_HOME=/opt/gradle

COPY --from=eclipse_jdk $JAVA_HOME $JAVA_HOME

ARG GRADLE_URL
#hadolint ignore=DL3003,DL4006,SC2046
RUN set -eux; \
    (cd /opt; curl -sL ${GRADLE_URL} -o- | $JAVA_HOME/bin/jar -xf /dev/stdin; ); \
    ln -s $(ls -1d /opt/gradle*) /opt/gradle; \
    chmod a+x /opt/gradle/bin/gradle

ENV PATH="${GRADLE_HOME}/bin:${JAVA_HOME}/bin:${PATH}"
