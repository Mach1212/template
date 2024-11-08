# Fully reproducable Dioxus fullstack project.

## Scripts

- tailwind.sh: Runs tailwind with hot reloading.
- build_n_deploy: Builds the dockerfile and pushes tag to repo.

## Dev

1. `nix develop`: Installs all developer dependencies which are needed to code and build the project.
2. `cargo install dioxus-cli@0.6.0-alpha.4`: Installs dx which is needed to build and run the project outside of the dockerfile.
3. `dx serve`: Run hot reloading Dioxus webserver.
4. `./tailwind.sh`: Run hot reloading tailwind.
5. Code!
