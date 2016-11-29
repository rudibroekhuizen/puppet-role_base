# == Class: role_base::server_drupal
#
class role_base::server_drupal {

  class { 'role_apache': }
  class { 'role_mysql': }
  class { 'role_php': }

  include composer

  drush::drush { 'drush8':
    version   => '8',
    link_name => '/usr/local/bin/drush8',
  }

}
