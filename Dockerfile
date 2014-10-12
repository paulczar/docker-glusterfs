# This file creates a container that runs Database (Percona) with Galera Replication.
#
# Author: Paul Czarkowski
# Date: 08/16/2014

FROM debian:wheezy
MAINTAINER Paul Czarkowski "paul@paulcz.net"

# Base Deps
RUN \
  apt-get update && apt-get install -yq \
  make \
  ca-certificates \
  net-tools \
  sudo \
  wget \
  vim \
  strace \
  lsof \
  netcat \
  lsb-release \
  locales \
  socat \
  --no-install-recommends

# generate a local to suppress warnings
RUN locale-gen en_US.UTF-8

RUN \
  wget -O - http://download.gluster.org/pub/gluster/glusterfs/3.5/LATEST/Debian/pubkey.gpg | apt-key add - && \
  echo "deb http://download.gluster.org/pub/gluster/glusterfs/3.3/LATEST/Debian/apt/ wheezy main" > /etc/apt/sources.list.d/gluster.list && \
  apt-get update && \
  DEBIAN_FRONTEND=noninteractive apt-get install -y glusterfs-server attr

# download latest stable etcdctl
ADD https://s3-us-west-2.amazonaws.com/opdemand/etcdctl-v0.4.5 /usr/local/bin/etcdctl
RUN chmod +x /usr/local/bin/etcdctl

# install confd
ADD https://s3-us-west-2.amazonaws.com/opdemand/confd-v0.5.0-json /usr/local/bin/confd
RUN chmod +x /usr/local/bin/confd

# Define mountable directories.
VOLUME ["/var/lib/glusterd/vols"]

ADD . /app

# Define working directory.
WORKDIR /app

RUN chmod +x /app/bin/*

# Define default command.
CMD ["/app/bin/boot"]

# Expose ports.
EXPOSE 111 245 443 24007 2049 8080 6010 6011 6012 38465 38466 38468 38469 49152 49153 49154 49156 49157 49158 49159 49160 49161 49162
