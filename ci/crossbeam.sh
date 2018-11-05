#!/bin/bash

cd "$(dirname "$0")"/..
set -ex

export RUSTFLAGS="-D warnings"

cargo build --no-default-features
cargo test

if [[ "$TRAVIS_RUST_VERSION" == "nightly" ]]; then
    cargo test --features nightly
fi

# TODO(stjepang): Uncomment the following lines once we fix the dependency tree
# if [[ "$TRAVIS_RUST_VERSION" == "nightly" ]]; then
#     cargo install cargo-tree
#     (cargo tree --duplicate | grep "^crossbeam") && exit 1
# fi