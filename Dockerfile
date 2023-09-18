FROM debian:bookworm-20230904-slim

LABEL mantainer="Jeremías Casteglione <jeremias@talkingpts.org>"
LABEL version="230918"

USER root:root
WORKDIR /root

ENV USER root
ENV HOME /root

COPY ./docker/apt-*.sh /root/bin/
RUN chmod -v 0750 /root/bin /root/bin/*.sh

RUN /root/bin/apt-install.sh bash ca-certificates locales tar gzip bzip2 \
	xz-utils zip unzip libfontconfig1 openssl build-essential curl procps git \
	python3

RUN echo 'en_US.UTF-8 UTF-8' >/etc/locale.gen \
	&& locale-gen \
	&& update-locale LANG=en_US.UTF-8

RUN install -v -d -m 0755 -o nobody -g nogroup /home/nobody /opt/src

RUN chgrp -v nogroup /usr/local/bin /opt
RUN chmod -v 0775 /usr/local/bin /opt

USER nobody:nogroup
WORKDIR /home/nobody

ENV USER nobody
ENV HOME /home/nobody

RUN curl -sS https://install.meteor.com/ | /bin/sh

RUN export METEOR_NODE=$(meteor node -e "process.stdout.write(process.execPath)"); \
	export METEOR_NPM=$(dirname ${METEOR_NODE})/npm; \
	export METEOR_NPX=$(dirname ${METEOR_NODE})/npx; \
	ln -sv ${METEOR_NODE} /usr/local/bin/node \
	&& ln -sv ${METEOR_NPM} /usr/local/bin/npm \
	&& ln -sv ${METEOR_NPX} /usr/local/bin/npx

RUN echo "*** $(meteor --version)" \
	&& echo "***   Node $(node --version)" \
	&& echo "***    NPM $(npm --version)" \
	&& echo "***    NPX $(npx --version)"

RUN npm config set color false

ENV NO_COLOR 1
ENV NODE_DISABLE_COLORS 1

COPY --chown=nobody:nogroup ./src/ /opt/src

WORKDIR /opt/src

RUN npm install --no-audit

RUN meteor build --platforms=web.browser --directory /opt/app

WORKDIR /opt/app/bundle/programs/server

RUN npm install --production

WORKDIR /opt/app/bundle

ENV PORT 3000
ENV ROOT_URL http://localhost

ENTRYPOINT /usr/local/bin/node main.js
