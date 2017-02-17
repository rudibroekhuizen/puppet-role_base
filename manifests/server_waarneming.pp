# == Class: role_base::server_waarneming
#
class role_base::server_waarneming {
  class { 'role_waarneming::conf': }
  class { 'role_waarneming::db': }
}
