# pdnsmanager PHP-FPM Docker container

This container runs a php-fpm process, serving a (pdnsmanager)[https://pdnsmanager.org/quickstart/] installation.

It's based on php:7.3-fpm-alpine and contains all necessary PHP extensions to run the pdnsmanager frontend properly. Image size is only around 80MB.

## Configuration

### pdnsmanager version

You can supply a specific pdnsmanager version at build time via the PDNSMANAGER_VERSION argument. Defaults to "master".

### pdnsmanager configuration

pdnsmanager saves its configuration under `backend/config/ConfigUser.php`.  
pdnsmanager's install path is `/pdnsmanager`, so the full path to the config file is `/pdnsmanager/backend/config/ConfigUser.php`.

This file is declared as `VOLUME`. Make sure to use it as such in order to 
have a persistent config between image updates.


