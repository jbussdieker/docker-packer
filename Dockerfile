FROM ubuntu

LABEL description="Packer"

RUN apt-get -y update && \
  apt-get -y install curl unzip

ARG packer_version

RUN : "${packer_version:?Must specify version}"

RUN curl -OL https://releases.hashicorp.com/packer/${packer_version}/packer_${packer_version}_linux_amd64.zip && \
  unzip packer_${packer_version}_linux_amd64.zip && \
  mv packer /usr/local/bin/packer
