FROM docker.io/clux/muslrust:1.84.0-nightly-2024-11-03 as builder
WORKDIR /app

RUN cargo install dioxus-cli@0.6.0-alpha.4

COPY Cargo.toml Cargo.lock ./
RUN mkdir src \
  && echo 'fn main(){}' >src/main.rs \
  && cargo build --release --locked --target x86_64-unknown-linux-musl \
  # && nix-shell -p gnused --run "sed -i 's/version = 4/version = 3/' Cargo.lock" \
  && rm -rf src target

COPY . .
RUN /root/.cargo/bin/dx build --release --target x86_64-unknown-linux-musl -- --locked \
  && mv /app/target/dx/frontend/release/web/public /app/target/dx/frontend/release/web/dist

FROM scratch
WORKDIR /app

COPY --from=builder /app/target/dx/frontend/release/web ./

CMD ["./server" ]

STOPSIGNAL SIGKILL
EXPOSE 8080
