# == Class: role_base::server-sensu
#
class role_base::server-sensu {
  class { 'role_sensu': }
}
