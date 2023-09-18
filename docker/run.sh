#!/bin/sh
exec docker run -it --rm \
	--name mementeor-run \
	--hostname mementeor.run.local \
	-u nobody \
	-p 127.0.0.1:3000:3000 \
	mementeor
