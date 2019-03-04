#!/bin/sh
set -e

git clone --depth 1 --branch ${PDNSMANAGER_VERSION} \
    https://github.com/loewexy/pdnsmanager.git /pdnsmanager

ln -sf /config.php /pdnsmanager/backend/config/ConfigUser.php

exec "$@"
