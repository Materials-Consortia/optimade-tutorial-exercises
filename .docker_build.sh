#!/bin/sh

# The README can be synced with the notebooks with the following docker invocation
docker run --rm --volume "`pwd`:/data" --entrypoint "/data/.build.sh"  pandoc/core
