classes:
  - role_base::server_mysql
  - php

# MySQL root_password
role_mysql::mysql_root_password: 'mypass'

# MySQL override_options
role_mysql::override_options:
  mysqld:
    bind-address: '0.0.0.0'
    max_allowed_packet: '512M'

# MySQL users
role_mysql::users:
  'drupal@localhost':
    ensure: 'present'
    password: 'mypass'
  'drupal@%':
    ensure: 'present'
    password: 'mypass'

# MySQL grants
role_mysql::grants:
  'drupal@localhost/mydb.*':
    privileges:
      - ALL
    table: 'drupaldb.*'
    user: 'drupal@localhost'
  'drupal@%/mydb.*':
    privileges:
      - ALL
    table: 'drupaldb.*'
    user: 'drupal@%'

# MySQL create databases with extra user
role_mysql::db_hash:
  drupaldb:
    user: 'manager'
    password: 'mypass'
    host: 'localhost'
    grant:
      - SELECT

# PHP settings
php::ensure: latest
php::manage_repos: true
php::fpm: true
php::dev: true
php::composer: true
php::pear: true
php::phpunit: false
php::settings:
  'PHP/max_execution_time': '90'
  'PHP/max_input_time': '300'
  'PHP/memory_limit': '64M'
  'PHP/post_max_size': '32M'
  'PHP/upload_max_filesize': '32M'
  'Date/date.timezone': 'Europe/Berlin'
php::extensions:
  bcmath: {}
  xmlrpc: {}
  imagick:
    provider: pecl
  apc:
    provider: pecl
    settings:
      'apc/stat': 1
      'apc/stat_ctime': 1
    sapi: 'fpm'
php::fpm::pools:
  www2:
    listen: '127.0.1.1:9000'
