# Set up LAPP (PostGreSQL) stack for Drupal
classes:
  - role_apache
  - role_mysql
  - role_php

# Apache
role_apache::vhosts_hash:
  drupal:
    directoryindex: 'index.php'
    docroot: '/var/www/drupal'
    docroot_owner: 'www-data'
    docroot_group: 'www-data'
    override: 'ALL'
    port: '80'
    priority: '5'
    servername: 'broekhuizen.online'
    serveraliases:
      - '*.broekhuizen.online'
    virtual_docroot: '/var/www/drupal'
    port: '80'

# PostGreSQL

# PHP settings
role_php::settings:
   PHP/max_execution_time: '90'
   PHP/max_input_time: '300'
   PHP/memory_limit: '128M'
   PHP/post_max_size: '32M'
   PHP/upload_max_filesize: '32M'
   PHP/allow_url_fopen: 'Off'
   Date/date.timezone: 'Europe/Berlin'
# PHP extensions
role_php::extensions:
  gd: {}
  mysql: {}
