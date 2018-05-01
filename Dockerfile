FROM openshift/rhel-atomic:latest

ARG JAVA_VERSION=1.8.0

LABEL name="java-openjdk" \
    version="8" \
    io.openshift.tags="base,java,runtime,openjdk" \
    io.k8s.description="OpenJDK base image providing java runtime" \
    io.k8s.display-name="Java 8"

ENV JAVA_HOME="/usr/lib/jvm" \
    JAVA_VERSION="${JAVA_VERSION}"

RUN microdnf install \
        --enablerepo=rhel-7-server-rpms \
        --enablerepo=rhel-7-server-thirdparty-oracle-java-rpms \
        --nodocs \
        java-${JAVA_VERSION}-openjdk-headless \
    && microdnf clean all \
    && find /etc/pki/ca-trust/source/anchors -type f \
        -exec cp {} ${JAVA_HOME}/jre/lib/security/ \;
