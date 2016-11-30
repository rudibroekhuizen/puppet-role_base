# == Class: role_base::server_drupal
#
class role_base::server_drupal {

  stage { 'post':
    require => Stage["main"],
  }

  class { 'role_apache': } ->
  class { 'role_mysql': } ->
  class { 'role_php': } ->
  class { 'drush': 
    stage => post
  }

}
