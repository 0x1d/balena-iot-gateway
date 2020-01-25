#!/bin/sh

traefik \
    --providers.docker="true" \
    --providers.docker.exposedbydefault="false" \
    --entrypoints.web.address=:"80" \
    --log.level="ERROR" \
    --log.filepath="/dev/console" \
    --accesslog.filepath="/dev/console" \
    --global.sendAnonymousUsage="false"