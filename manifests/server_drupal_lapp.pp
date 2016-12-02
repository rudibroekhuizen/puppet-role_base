# == Class: role_base::server_drupal_lapp
#
class role_base::server_drupal_lapp {

  stage { 'post':
    require => Stage["main"],
  }

  class { 'role_apache': } ->
  class { 'role_postgresql': } ->
  class { 'role_php': } ->
  class { 'drush': 
    stage => post
  }

}
