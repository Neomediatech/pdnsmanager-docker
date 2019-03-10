# pdnsmanager PHP-FPM Docker container

This container runs php-fpm and nginx via supervisor, serving a [pdnsmanager](https://pdnsmanager.org/quickstart/) installation.

It's based on php:7.3-fpm-alpine and contains all necessary PHP extensions for pdnsmanager. Image size is around 50MB.

## Configuration

### pdnsmanager configuration

pdnsmanager saves its configuration under `backend/config/ConfigUser.php`.  

To make your configuration persietent between restarts and image updates, add 
`-v /local/path/config.php:/etc/pdnsmanager/ConfigUser.php` to your docker run command.

`/etc/pdnsmanager/ConfigUser.php` is a volume that's symlinked to the proper path.

## docker-compose example

```yaml
version: '3.3'

services:
    pdnsmanager:
        build: alexdo/pdnsmanager-fpm:2.0.1
        volumes:
          - ./ConfigUser.php:/etc/pdnsmanager/ConfigUser.php
        ports:
          - 7777:80
```

**Important:** Initialize `./ConfigUser.php` with empty contents before running `docker-compose up`.


