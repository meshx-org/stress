# stress-ng on Alpine — a modern, v2/OCI replacement for the ancient
# Docker-Schema-1 `progrium/stress` image. Keeps the good parts of
# github.com/progrium/docker-stress: a verbose stress entrypoint with NO baked
# workload; the load args are supplied per run.
FROM alpine:3.20
RUN apk add --no-cache stress-ng

LABEL org.opencontainers.image.title="stress" \
      org.opencontainers.image.description="stress-ng workload generator (CPU/mem/IO/disk); a v2/OCI replacement for progrium/stress" \
      org.opencontainers.image.source="https://github.com/meshx-org/stress"

# Verbose by default (as progrium/docker-stress did); no baked workload — the
# load is always supplied per run (a bare run just prints usage and exits).
ENTRYPOINT ["stress-ng", "--verbose"]
CMD []
