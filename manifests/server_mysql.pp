# == Class: role_base::server_mysql
#
class role_base::server_mysql {
  class { 'base': } ->
  class { 'role_mysql': }
}
