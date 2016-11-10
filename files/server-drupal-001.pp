classes:
  - role_base::server_mysql

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
