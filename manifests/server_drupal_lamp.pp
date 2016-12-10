# == Class: role_base::server_drupal_lamp
#
class role_base::server_drupal_lamp {

  stage { 'pre':
    before => Stage["main"]
  }

  stage { 'post':
    require => Stage["main"]
  }

  class { 'role_php': }
  class { 'role_mysql': }
  class { 'role_apache': 
    require => Class['::php:repo']
  }
  
  # Post
  class { 'drush': 
    stage => post
  }
  
}
