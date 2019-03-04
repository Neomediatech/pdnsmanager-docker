#!/bin/sh
set -e

cd /pdnsmanager 

if [[ ! -d "/pdnsmanager/.git" ]] ; then
	git clone --depth 1 --branch ${PDNSMANAGER_VERSION} \
		https://github.com/loewexy/pdnsmanager.git .
else

	if [[ "$(git rev-parse --abbrev-ref HEAD)" != "${PDNSMANAGER_VERSION}" || "${PDNSMANAGER_VERSION}" == "master" ]] ; then
		git reset --hard HEAD
		git clean -f -d
		git fetch --depth 1 origin
		git checkout ${PDNSMANAGER_VERSION}
	fi
fi

exec "$@"
