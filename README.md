# Customized version of pdnsmanager Docker container

Taken from @alexdo work (original README follow this section)

Database configuration is automatically taken from docker compose stack (see [ConfigUser.php file](etc/ConfigUser.php) for details)

-----

# pdnsmanager Docker container

This container runs a php-enabled apache instance, serving a [pdnsmanager](https://pdnsmanager.org/quickstart/) installation.

It's based on php:7.3-apache and contains all necessary PHP extensions for pdnsmanager. Image size is around 50MB.

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
        image: alexdo/pdnsmanager:latest
        volumes:
          - ./ConfigUser.php:/etc/pdnsmanager/ConfigUser.php
        ports:
          - 7777:80
```

**Important:** Initialize `./ConfigUser.php` with empty contents before running `docker-compose up`.


