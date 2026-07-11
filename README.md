# stress

A minimal container image for generating CPU / memory / I/O / disk load —
[stress-ng](https://github.com/ColinIanKing/stress-ng) on Alpine. Published to
`ghcr.io/meshx-org/stress`.

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

## Tags

`ghcr.io/meshx-org/stress` is published as:

- `:latest` — newest build
- `:<version>` — the stress-ng version, e.g. `:0.18.06`
- `:<major.minor>` — e.g. `:0.18`
- `:sha-<short>` — the exact commit (byte-immutable)

Version tags float with Alpine patches; pin `:sha-<short>` or a digest for an
immutable image. A matching git tag `v<version>` is pushed per stress-ng version.
