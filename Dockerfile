FROM php:7.3-fpm-alpine

RUN apk add --no-cache \
    nginx \
    supervisor

# Install pdnsmnanager php extensions
RUN docker-php-source extract \
	&& apk add --no-cache --virtual .build-dependencies \
		autoconf make g++ libtool \
	&& pecl install apcu \ 
	&& docker-php-ext-enable apcu \
	&& apk del .build-dependencies \
	&& docker-php-source delete \
	&& rm -rf /tmp/* /var/cache/apk/*

RUN docker-php-ext-install -j"$(getconf _NPROCESSORS_ONLN)" pdo_mysql

ENV VERSION 2.0.1
ENV URL https://dl.pdnsmanager.org/pdnsmanager-${VERSION}.tar.gz
LABEL version=$VERSION

RUN set -ex ; curl --output pdnsmanager.tar.gz --location ${URL} \
	&& tar xfz pdnsmanager.tar.gz -C /usr/src \
	&& rm pdnsmanager.tar.gz \
	&& mv /usr/src/pdnsmanager-${VERSION} /usr/src/pdnsmanager \
	&& mkdir -p /var/nginx/client_body_temp /sessions /etc/pdnsmanager

RUN rm -rf /usr/src/php.tar.xz*

# Copy configuration
COPY etc /etc/
COPY php.ini /usr/local/etc/php/conf.d/php-pdnsmanager.ini

# Copy main script
COPY run.sh /run.sh

# We expose pdnsmanager on port 80
EXPOSE 80

ENTRYPOINT [ "/run.sh" ]
CMD ["supervisord", "-n", "-j", "/supervisord.pid"]