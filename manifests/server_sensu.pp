# == Class: role_base::server_sensu
#
class role_base::server_sensu {
  class { 'base': } ->
  class { 'role_sensu': }
}
