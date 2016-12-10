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
  class { 'role_apache': }
  
  # Apache php 7 modules after php is installed
  class {'::apache::mod::php':
    php_version => '7.0',
    stage       => post
  }
  
  # Install Drush
  class { 'drush': 
    stage => post
  }
  
}
