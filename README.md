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

`ghcr.io/meshx-org/stress` is published as (node-image style — both the app and
the base OS version are visible):

- `:latest` — newest build
- `:<version>` — the stress-ng version, e.g. `:0.21.02`
- `:<major.minor>` — e.g. `:0.21`
- `:<version>-alpine<alpine>` — fully qualified, e.g. `:0.21.02-alpine3.24`
- `:sha-<short>` — the exact commit (byte-immutable)

A matching git tag `v<version>` is pushed per stress-ng version.

Both the base OS and stress-ng are pinned in the [`Dockerfile`](Dockerfile) as
`ARG ALPINE_VERSION` / `ARG STRESS_NG_VERSION`.
[`update-version.yaml`](.github/workflows/update-version.yaml) (daily) bumps them
as a matched pair when Alpine 3.x ships a new stress-ng; Dependabot surfaces a
major Alpine bump; [`smoke.yaml`](.github/workflows/smoke.yaml) builds and runs
the image on every change to prove it works.

## Supply chain

Every published image is signed and comes with an SBOM and SLSA build provenance,
all keyless (Sigstore + GitHub OIDC — no long-lived keys). To verify:

```sh
IMAGE=ghcr.io/meshx-org/stress:latest

# Cosign signature (identity = this repo's publish workflow)
cosign verify "$IMAGE" \
  --certificate-identity-regexp '^https://github.com/meshx-org/stress/' \
  --certificate-oidc-issuer https://token.actions.githubusercontent.com

# SLSA build provenance + SBOM attestation
gh attestation verify "oci://$IMAGE" --owner meshx-org

# Pull the SBOM (SPDX) attached to the image
cosign download sbom "$IMAGE"
```

The SBOM is also published as a workflow artifact (`stress-sbom.spdx.json`) on
each `publish` run.
