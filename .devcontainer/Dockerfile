ARG UBUNTU_VERSION=14.04
FROM ubuntu:$UBUNTU_VERSION

RUN apt-get update \
    && apt-get install -y wget \
    && apt-get install -y python \
    && apt-get install -y python-pip \
    && apt-get install dos2unix\
    && apt-get clean

RUN python --version

ENTRYPOINT [ "python" ]
