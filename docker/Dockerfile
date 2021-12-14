##
# Image for the Cesium Terrain Server
#

FROM ubuntu:20.04 as build
# FROM debian:jessie-slim

ARG FRIENDLY_CHECKOUT
ARG CESIUM_VERSION

# Set correct environment variables.
ENV HOME /root
ENV FRIENDLY_CHECKOUT $FRIENDLY_CHECKOUT
ENV CESIUM_VERSION $CESIUM_VERSION

# Regenerate SSH host keys. baseimage-docker does not contain any, so you
# have to do that yourself. You may also comment out this instruction; the
# init system will auto-generate one during boot.
#RUN /etc/my_init.d/00_regen_ssh_host_keys.sh

# Update the location of the apt sources
RUN apt-get update -y

# Install dependencies
RUN apt-get install -y \
	ack-grep \
	curl \
	sed \
	wget \
	bash \
	build-essential \
	rsync \
	git

# RUN apt-get upgrade -y

# default all users to bash
RUN sed -i 's/\/bin\/sh/\/bin\/bash/g' /etc/passwd
#RUN ln -s /usr/bin/ack-grep /usr/bin/ack

# Install Go
ADD install-go.sh /tmp/
RUN /tmp/install-go.sh

# Set the Go workspace
RUN echo 'export GO111MODULE=on' >> /etc/bash.bashrc
RUN mkdir -p /root/go

ENV GOPATH=/root/go
ENV GOROOT=/usr/local/go
ENV GOBIN=/usr/local/go/bin

# Install the terrain server
ADD local/ /tmp/local/
ADD install-terrain-server.sh /tmp/
RUN /tmp/install-terrain-server.sh

# Install Cesium.js
#ADD install-cesiumjs.sh /tmp/
#RUN /tmp/install-cesiumjs.sh

FROM ubuntu:20.04
COPY --from=build /usr/local/go/bin/cesium-terrain-server /usr/local/go/bin/cesium-terrain-server

# default all users to bash
RUN sed -i 's/\/bin\/sh/\/bin\/bash/g' /etc/passwd

# Update the location of the apt sources
#RUN apt-get update -y

# Install dependencies
#RUN apt-get install -y \
#	rsync

# Add our filesystem updates
#ADD ./root-fs /tmp/root-fs
#RUN rsync -a /tmp/root-fs/ /

# Expose the terrain server
EXPOSE 8000

# Clean up APT when done
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ENTRYPOINT ["/usr/local/go/bin/cesium-terrain-server","-dir=/data/tilesets/terrain"]