# == Class: role_base::server_waarneming_db_slave
#
class role_base::server_waarneming_db_slave {
  
  class { 'role_waarneming::common': }
  class { 'role_waarneming::conf': }
  class { 'role_waarneming::db_slave': }
  
}
