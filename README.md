# stress

A minimal container image for generating CPU / memory / I/O / disk load —
[stress-ng](https://github.com/ColinIanKing/stress-ng) on Alpine. Published to
`ghcr.io/meshx-org/stress`.

A v2/OCI replacement for the ancient (Docker Schema-1) `progrium/stress` image,
keeping the good parts of
[progrium/docker-stress](https://github.com/progrium/docker-stress): a verbose
entrypoint with **no baked workload** — you always supply the load.

## Usage

```sh
docker run --rm ghcr.io/meshx-org/stress --cpu 2 --io 1 --vm 2 --vm-bytes 128M --timeout 10s
```

`stress-ng` is a superset of the classic `stress` tool and CLI-compatible for the
common stressors:

| Load       | Args                                     |
| ---------- | ---------------------------------------- |
| CPU        | `--cpu 2 --timeout 60s`                  |
| Memory     | `--vm 1 --vm-bytes 512M --timeout 60s`   |
| I/O (sync) | `--io 1 --timeout 60s`                   |
| Disk       | `--hdd 1 --hdd-bytes 256M --timeout 60s` |

Omit `--timeout` to run until the container is stopped. Run with no args to see
the full `stress-ng` usage.

## Publishing

`.github/workflows/publish.yaml` builds and pushes `ghcr.io/meshx-org/stress` on
every push to `main` (`:latest` + `:sha-<short>`), using only the built-in
`GITHUB_TOKEN`. After the first publish, set the package's visibility to
**public** (repo → Packages → stress → Package settings) so it can be pulled
anonymously — e.g. by the meshx rootfs pipeline.
