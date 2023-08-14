#!/usr/bin/env bash

echo "Building release with the following variables"
echo "TARGET=${TARGET}"
echo "FEATURES=${FEATURES}"
echo

# Add the target
#rustup target install "${TARGET}"

mkdir --parents "${HOME}/.cargo"
[[ -f "${HOME}/.cargo/config" ]] && rm "${HOME}/.cargo/config"

# Attempt to fix ssl by using the vendored version.
#cat >> ~/.cargo/config << EOF
#[dependencies]
#openssl = { version = "0.9", features = ["vendored"] }
#EOF

# Statically compile the binary
cat >> "${HOME}/.cargo/config" << EOF
[target.x86_64-unknown-linux-gnu]
rustflags = ["-C", "target-feature=+crt-static"]
EOF

head -20 "${HOME}/.cargo/config"

# Build the release
cd "${WORKDIR}" || exit
echo cargo build --release --target "${TARGET}" --features "${FEATURES}"
cargo build --release --target "${TARGET}" --features "${FEATURES}"
