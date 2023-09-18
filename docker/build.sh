#!/bin/sh
exec docker build --platform=linux/amd64 --rm -t mementeor -f ./Dockerfile .
