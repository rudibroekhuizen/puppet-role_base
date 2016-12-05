# == Class: role_base::server_wordpress
#
class role_base::server_wordpress {

  #stage { 'post':
  #  require => Stage["main"],
  #}

  class { 'role_apache': }
  class { 'role_mysql': }
  class { 'role_php': }

}
