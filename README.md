# pdnsmanager PHP-FPM Docker container

**Warning** NOT YET TESTED - WORK IN PROGRESS

This container runs a php-fpm process, serving a [pdnsmanager](https://pdnsmanager.org/quickstart/) installation.

It's based on php:7.3-fpm-alpine and contains all necessary PHP extensions to run the pdnsmanager frontend properly. Image size is only around 90MB.

## Configuration

### pdnsmanager version

You can supply a specific pdnsmanager version at build time via the PDNSMANAGER_VERSION argument. Defaults to "master".
To update, just start the container with a changed version. Or stay on master, because the code will be fetched automatically on every container boot.

### pdnsmanager configuration

pdnsmanager saves its configuration under `backend/config/ConfigUser.php`.  
To make your configuration persietent between restarts and image updates, add `-v
/local/path/config.php:/config.php`. `/config.php` is a volume that's symlinked
to the proper path.

