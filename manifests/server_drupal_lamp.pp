# == Class: role_base::server_drupal_lamp
#
class role_base::server_drupal_lamp {

  stage { 'post':
    require => Stage["main"],
  }

  class { 'role_php': } ->
  class { 'role_mysql': } ->
  class { 'role_apache': }
  
  
  class { 'drush': 
    stage => post
  }
  
}
