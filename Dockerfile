# stress-ng on Alpine — a verbose stress entrypoint with NO baked workload; the
# load args are supplied per run (the good parts of github.com/progrium/docker-stress).
# The `alpine:3` tag (not a patch pin) lets the scheduled rebuild track the latest
# 3.x base, while STRESS_NG_VERSION pins the exact stress-ng package for a
# reproducible build. CI passes it from the committed VERSION file (kept current
# by .github/workflows/update-version.yaml); a bare `docker build` with no arg
# falls back to the latest stress-ng in the repo.
FROM alpine:3

ARG STRESS_NG_VERSION=
RUN if [ -n "$STRESS_NG_VERSION" ]; then \
        apk add --no-cache "stress-ng=$STRESS_NG_VERSION"; \
    else \
        apk add --no-cache stress-ng; \
    fi

LABEL org.opencontainers.image.title="stress" \
      org.opencontainers.image.description="stress-ng workload generator (CPU/mem/IO/disk)" \
      org.opencontainers.image.source="https://github.com/meshx-org/stress"

# Verbose by default (as progrium/docker-stress did); no baked workload — the
# load is always supplied per run (a bare run just prints usage and exits).
ENTRYPOINT ["stress-ng", "--verbose"]
CMD []
