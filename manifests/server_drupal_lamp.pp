# == Class: role_base::server_drupal_lamp
#
class role_base::server_drupal_lamp {

  stage { 'post':
    require => Stage["main"],
  }

  class { 'role_apache': }
  class { 'role_mysql': }
  class { 'role_php': }
  class { 'drush': 
    stage => post
  }
  
  #package { 'libapache2-mod-php7.0':
  #  ensure => 'installed',
  #}

}
