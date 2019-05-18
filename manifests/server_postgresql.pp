# == Class: role_base::server_postgresql
#
class role_base::server_postgresql {

  class { 'postgresql::server': }
  class { 'postgresql::globals': }
 
}
