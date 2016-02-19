# == Class: role_base::server-mysql
#
class role_base::server-mysql {
  class { 'base': } ->
  class { 'role_mysql': }
}
