#!/bin/sh
if [ "$1" == php-fpm ] || [ "$1" == supervisord ] ; then
    if [ "$(id -u)" = '0' ]; then
        user='www-data'
        group='www-data'
    else
        user="$(id -u)"
        group="$(id -g)"
    fi

    chown www-data:www-data /sessions /var/nginx/client_body_temp

    if ! [ -f frontend/index.html ]; then
        echo >&2 "pdnsmanager not found in $PWD - copying now..."
        if [ "$(ls -A)" ]; then
            echo >&2 "WARNING: $PWD is not empty - press Ctrl+C now if this is an error!"
            ( set -x; ls -A; sleep 10 )
        fi
        tar --create \
            --file - \
            --one-file-system \
            --directory /usr/src/pdnsmanager \
            --owner "$user" --group "$group" \
            . | tar --extract --file -
        echo >&2 "Complete! pdnsmanager has been successfully copied to $PWD"
        mkdir -p tmp; \
        chmod -R 777 tmp; \
    fi

    if [ ! -f /etc/pdnsmanager/ConfigUser.php ]; then
        touch /etc/pdnsmanager/ConfigUser.php
    fi

    chown www-data:www-data /etc/pdnsmanager/ConfigUser.php

    if [ ! -f /var/www/html/backend/config/ConfigUser.php ]; then
        ln -sf /etc/pdnsmanager/ConfigUser.php /var/www/html/backend/config/ConfigUser.php
    fi
fi

exec "$@"