#!/usr/bin/env bash

echo "Building release with the following variables"
echo "TARGET=${TARGET}"
echo

cp /app/pyoxidizer.bzl .
app_path="."
ls -la
#./pyoxidizer python-distribution-extract --download-default --verbose ${app_path}
#./pyoxidizer list-targets ${app_path}
./pyoxidizer build --release --verbose --path ${app_path}
