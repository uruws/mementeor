#!/bin/sh
set -eu
docker build --platform=linux/amd64 --rm \
	-t uws/buildpack:base-2305 \
	-f ./Dockerfile .
exit 0
