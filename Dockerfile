# stress-ng on Alpine — a verbose stress entrypoint with NO baked workload; the
# load args are supplied per run (the good parts of github.com/progrium/docker-stress).
# Pinned to the `alpine:3` tag (not a patch pin) so the scheduled rebuild in
# .github/workflows/publish.yaml auto-tracks the latest 3.x base + stress-ng with
# no manual bumps.
FROM alpine:3
RUN apk add --no-cache stress-ng

LABEL org.opencontainers.image.title="stress" \
      org.opencontainers.image.description="stress-ng workload generator (CPU/mem/IO/disk); a v2/OCI replacement for progrium/stress" \
      org.opencontainers.image.source="https://github.com/meshx-org/stress"

# Verbose by default (as progrium/docker-stress did); no baked workload — the
# load is always supplied per run (a bare run just prints usage and exits).
ENTRYPOINT ["stress-ng", "--verbose"]
CMD []
