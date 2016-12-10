# == Class: role_base::server_drupal_lamp
#
class role_base::server_drupal_lamp {

  stage { 'pre':
    before => Stage["main"],
  }

  stage { 'post':
    require => Stage["main"],
  }

  # Pre
  class { 'role_php':
    stage => pre
  }
  
  # Main
  class { 'role_mysql': }
  class { 'role_apache': }
  
  # Post
  class { 'drush': 
    stage => post
  }
  
}
