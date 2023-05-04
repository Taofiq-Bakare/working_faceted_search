ARG UBUNTU_VERSION=14.04
FROM ubuntu:$UBUNTU_VERSION

RUN apt-get update \
    && apt-get install -y python python-pip \
    && apt-get clean

RUN python --version

ENTRYPOINT [ "python" ]