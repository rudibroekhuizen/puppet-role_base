# == Class: role_base::server_xenocanto
#
class role_base::server_xenocanto {

  class { 'role_xenocanto::db': }
 
}
