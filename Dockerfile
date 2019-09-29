FROM php:7.3-apache

# Install pdnsmnanager php extensions
RUN pecl install apcu && docker-php-ext-enable apcu
RUN docker-php-ext-install -j"$(getconf _NPROCESSORS_ONLN)" pdo_mysql

RUN a2enmod rewrite alias

ENV VERSION 2.0.1
ENV URL https://github.com/Neomediatech/pdnsmanager-archive/raw/master/pdnsmanager-${VERSION}.tar.gz
LABEL version=$VERSION

RUN set -ex ; curl --output pdnsmanager.tar.gz --location ${URL} \
	&& tar xfz pdnsmanager.tar.gz -C /usr/src \
	&& rm pdnsmanager.tar.gz \
	&& mv /usr/src/pdnsmanager-${VERSION} /usr/src/pdnsmanager \
	&& mkdir -p /sessions /etc/pdnsmanager

RUN rm -rf /usr/src/php.tar.xz*

# Copy configuration
RUN rm -rf /etc/apache2/sites-enabled/*
COPY etc/apache2-vhost.conf /etc/apache2/sites-enabled/vhost.conf
COPY etc/php.ini /etc/php/7.3/apache2/php.ini

# Copy main script
COPY run.sh /run.sh

# We expose pdnsmanager on port 80
EXPOSE 80

ENTRYPOINT [ "/run.sh" ]
CMD [ "apache2-foreground" ]
