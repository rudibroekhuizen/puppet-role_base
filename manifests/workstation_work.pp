# == Class: role_base::workstation_work
#
class role_base::workstation_work {
  
  class { 'docker':
    docker_users => ['rudi.broekhuizen'],
  }
  
  class {'docker::compose': 
    ensure => present,
  }
  
  #class { 'sqlplus': }
  #class { 'role_burp': }
  #class { 'role_tftp': }
}
