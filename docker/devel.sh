#!/bin/sh
exec docker run -it --rm \
	--name mementeor-devel \
	--hostname mementeor.devel.local \
	-u nobody \
	--entrypoint /bin/bash \
	mementeor
