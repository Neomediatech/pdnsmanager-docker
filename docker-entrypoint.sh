#!/bin/sh
set -e

if [[ ! -d "/pdnsmanager" ]] ; then
	git clone --depth 1 --branch ${PDNSMANAGER_VERSION} \
		https://github.com/loewexy/pdnsmanager.git /pdnsmanager
else
	cd /pdnsmanager 

	if [[ "$(git rev-parse --abbrev-ref HEAD)" != "${PDNSMANAGER_VERSION}" || "${PDNSMANAGER_VERSION}" == "master" ]] ; then
		git reset --hard HEAD
		git clean -f -d
		git fetch --depth 1 origin
		git checkout ${PDNSMANAGER_VERSION}
	fi
fi

if [[ -f "/config.php" ]] ; then
	ln -sf /config.php /pdnsmanager/backend/config/ConfigUser.php
fi

exec "$@"
