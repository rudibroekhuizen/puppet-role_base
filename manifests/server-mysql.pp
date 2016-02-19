# == Class: role_base::server-mysql
#
class role_base::server-mysql {
  class { 'role_mysql': }
}
