# stress-ng on Alpine — a verbose stress entrypoint with NO baked workload; the
# load args are supplied per run (the good parts of github.com/progrium/docker-stress).
#
# Both versions are pinned here, node-image style: ALPINE_VERSION selects the base
# OS, STRESS_NG_VERSION pins the exact apk package. update-version.yaml keeps them
# current as a matched pair (the stress-ng build shipped by a given Alpine 3.x
# release), and the published tags encode both, e.g. `0.21.02-alpine3.24`. A bare
# `docker build` uses the pins below; override either with --build-arg.
ARG ALPINE_VERSION=3.24
FROM alpine:${ALPINE_VERSION}
ARG ALPINE_VERSION

ARG STRESS_NG_VERSION=0.21.02-r0
RUN apk add --no-cache "stress-ng=${STRESS_NG_VERSION}"

LABEL org.opencontainers.image.title="stress" \
      org.opencontainers.image.description="stress-ng workload generator (CPU/mem/IO/disk)" \
      org.opencontainers.image.source="https://github.com/meshx-org/stress" \
      org.opencontainers.image.base.name="alpine:${ALPINE_VERSION}"

# Verbose by default (as progrium/docker-stress did); no baked workload — the
# load is always supplied per run (a bare run just prints usage and exits).
ENTRYPOINT ["stress-ng", "--verbose"]
CMD []
