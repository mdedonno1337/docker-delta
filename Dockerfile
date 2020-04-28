FROM rust

RUN apt-get update && \
    apt-get install -y cmake pkg-config clang

RUN git clone https://github.com/dandavison/delta.git /tmp/delta

WORKDIR /tmp/delta

RUN git checkout tags/$(git describe --tags $(git rev-list --tags --max-count=1))

RUN RUSTFLAGS='-C link-arg=-s' cargo build --release

