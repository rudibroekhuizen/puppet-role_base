# == Class: role_base::client-sensu
#
class role_base::client-sensu {
  class { 'role_sensu': }
}
