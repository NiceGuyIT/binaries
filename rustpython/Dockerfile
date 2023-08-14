# We'll just use the official Rust image rather than build our own from scratch.
FROM docker.io/library/rust:1.71.0-bookworm
# Or use the cross docker image which contains the all tools needed for cross compilation.
#FROM ghcr.io/cross-rs/x86_64-pc-windows-gnu:latest

#WORKDIR /rustpython

# Skip "recommended" to reduce total size
RUN apt-get update && \
    apt-get install --no-install-recommends --yes \
        pkg-config \
        libssl-dev \
        openssl \
        zlib1g-dev

# Clone the repo
#RUN git clone https://github.com/RustPython/RustPython.git .

#ARG FEATURES=${FEATURES}
#ARG TARGET=${TARGET}

# Not needed since cross-compilation of ssl/ssl-vendor doesn't work
# RUN mkdir /root/.cargo && \
#     echo -e '[dependencies]\nopenssl = { version = "0.9", features = ["vendored"] }' > ~/.cargo/config

# Add the target for cross-compilation
# rustup target install aarch64-apple-darwin
#RUN rustup target install "${TARGET}"

# Compile the target
#RUN cargo build --release --target "${TARGET}" --features "${FEATURES}"
