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
  
  # Require php::repo needed for Apache PhP extenstions (libapache2-mod-php7.0, php7.0-mysql, etc)
  class { 'role_apache': 
    require => Class['::php::repo']
  }
  
  # Post
  class { 'drush': 
    stage => post
  }
  
}
