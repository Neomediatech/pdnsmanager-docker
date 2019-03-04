FROM php:7.3-fpm-alpine

ENV PDNSMANAGER_VERSION="${PDNSMANAGER_VERSION:-master}"

RUN docker-php-source extract \
	&& apk add --no-cache --virtual .build-dependencies \
		autoconf make g++ libtool \
	&& pecl install apcu \ 
	&& docker-php-ext-enable apcu \
	&& apk del .build-dependencies \
	&& docker-php-source delete \
	&& rm -rf /tmp/* /var/cache/apk/*

RUN docker-php-ext-install -j"$(getconf _NPROCESSORS_ONLN)" pdo_mysql

RUN apk add --no-cache git \
	&& rm -rf /tmp/* /var/cache/apk/*

VOLUME /config.php

COPY docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["php-fpm"]
