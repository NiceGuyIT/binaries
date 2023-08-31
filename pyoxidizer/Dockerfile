# PyOxidizer manages a Rust toolchain.
# Debian 12 Bookworm
#FROM docker.io/library/rust:1.72.0-bookworm
#FROM python:3.10-slim-bookworm AS build-stage
FROM python:3.10-bookworm AS build-stage
# Or use the cross docker image which contains the all tools needed for cross compilation.
#FROM ghcr.io/cross-rs/x86_64-pc-windows-gnu:latest

WORKDIR /build

ARG TARGET=${TARGET}
ARG PYOXIDIZER_VERSION=${PYOXIDIZER_VERSION}

# Skip "recommended" to reduce total size
# musl-dev may not be needed
RUN apt-get update && \
    apt-get install --no-install-recommends --yes \
        musl-tools \
        curl \
        gcc \
        make \
        musl \
        musl-dev \
        linux-libc-dev

# Download pyoxidizer
RUN mkdir --parents "/build" && \
    cd "/build" && \
    repo_url="https://github.com/indygreg/PyOxidizer/releases/download/" && \
    arch=$(uname -m) && \
    os=$(uname -s | tr '[:upper:]' '[:lower:]') && \
    archive_name="pyoxidizer-${PYOXIDIZER_VERSION}-${arch}-unknown-${os}-musl" && \
    curl --location --silent --output - "${repo_url}/pyoxidizer%2F${PYOXIDIZER_VERSION}/${archive_name}.tar.gz" | \
        tar --extract --gunzip --strip-components 1 --file - "${archive_name}/pyoxidizer"
