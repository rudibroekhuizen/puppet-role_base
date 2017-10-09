# == Class: role_base::server_xenocanto_db
#
class role_base::server_xenocanto_db {

  class { 'role_xenocanto::db': }
 
}
